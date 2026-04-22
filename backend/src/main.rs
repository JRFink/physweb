use axum::{extract::State, routing::{get, post}, Json, Router};
use aws_sdk_sesv2::Client as SesClient;
use aws_sdk_sesv2::types::{Body, Content, Destination, EmailContent, Message as SesMessage};
use serde::{Deserialize, Serialize};
use serde_json::{json, Value};
use sqlx::mysql::MySqlPool;
use std::{env, sync::Arc};
use tower_http::cors::CorsLayer;
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};

#[derive(Clone)]
struct AppState {
    db: MySqlPool,
    ses: Arc<SesClient>,
}

#[derive(Deserialize)]
struct SubscribeRequest {
    email: String,
}

#[derive(Serialize)]
struct ApiResponse {
    success: bool,
    message: String,
}

#[tokio::main]
async fn main() {
    tracing_subscriber::registry()
        .with(tracing_subscriber::EnvFilter::new(
            std::env::var("RUST_LOG").unwrap_or_else(|_| "info".into()),
        ))
        .with(tracing_subscriber::fmt::layer())
        .init();

    let aws_config = aws_config::load_from_env().await;
    let ses = Arc::new(SesClient::new(&aws_config));
    let db = create_db_pool().await;

    let state = AppState { db, ses };

    let app = Router::new()
        .route("/api/health", get(health))
        .route("/api/subscribe", post(subscribe_handler))
        .layer(CorsLayer::permissive())
        .with_state(state);

    let addr = "0.0.0.0:3001";
    tracing::info!("physweb backend listening on {}", addr);
    let listener = tokio::net::TcpListener::bind(addr).await.unwrap();
    axum::serve(listener, app).await.unwrap();
}

async fn create_db_pool() -> MySqlPool {
    let host     = env::var("DB_HOST").expect("DB_HOST not set");
    let port     = env::var("DB_PORT").unwrap_or_else(|_| "3306".to_string());
    let user     = env::var("DB_USER").expect("DB_USER not set");
    let password = env::var("DB_PASSWORD").expect("DB_PASSWORD not set");
    let name     = env::var("DB_NAME").expect("DB_NAME not set");

    let url = format!("mysql://{}:{}@{}:{}/{}", user, password, host, port, name);
    MySqlPool::connect(&url).await.expect("Failed to connect to MySQL")
}

async fn health() -> Json<Value> {
    Json(json!({ "status": "ok", "service": "physweb-api" }))
}

async fn subscribe_handler(
    State(state): State<AppState>,
    Json(body): Json<SubscribeRequest>,
) -> Json<ApiResponse> {
    let email = body.email.trim().to_lowercase();

    if !email.contains('@') || !email.contains('.') {
        return Json(ApiResponse {
            success: false,
            message: "Please enter a valid email address.".into(),
        });
    }

    let insert = sqlx::query("INSERT INTO physweb_users (email) VALUES (?)")
        .bind(&email)
        .execute(&state.db)
        .await;

    match insert {
        Err(sqlx::Error::Database(e)) if e.message().contains("Duplicate") => {
            return Json(ApiResponse {
                success: false,
                message: "You're already subscribed!".into(),
            });
        }
        Err(e) => {
            tracing::error!("DB insert error: {:?}", e);
            return Json(ApiResponse {
                success: false,
                message: "Something went wrong. Please try again.".into(),
            });
        }
        Ok(_) => {}
    }

    let email_body = format!(
        "New physweb newsletter subscriber!\n\nEmail: {}\n",
        email
    );

    let ses_result = state.ses
        .send_email()
        .from_email_address("info@fivestartutoring.com")
        .destination(
            Destination::builder()
                .to_addresses("info@fivestartutoring.com")
                .build()
        )
        .content(
            EmailContent::builder()
                .simple(
                    SesMessage::builder()
                        .subject(
                            Content::builder()
                                .data("New physweb subscriber")
                                .build()
                                .unwrap()
                        )
                        .body(
                            Body::builder()
                                .text(
                                    Content::builder()
                                        .data(email_body)
                                        .build()
                                        .unwrap()
                                )
                                .build()
                        )
                        .build()
                )
                .build()
        )
        .send()
        .await;

    if let Err(e) = ses_result {
        tracing::error!("SES error: {:?}", e);
    }

    Json(ApiResponse {
        success: true,
        message: "You're subscribed! We'll keep you in the loop.".into(),
    })
}
