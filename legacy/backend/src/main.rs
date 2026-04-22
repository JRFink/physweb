use axum::{routing::get, Router, Json};
use serde::Serialize;
use tower_http::{cors::CorsLayer, trace::TraceLayer};
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};
 
mod routes;
 
#[tokio::main]
async fn main() {
    tracing_subscriber::registry()
        .with(
            tracing_subscriber::EnvFilter::try_from_default_env()
                .unwrap_or_else(|_| "physweb=debug,tower_http=debug".into()),
        )
        .with(tracing_subscriber::fmt::layer())
        .init();
 
    let app = Router::new()
        .route("/api/health", get(health))
        .route("/api/constants", get(routes::constants::list_constants))
        .route("/api/constants/:symbol", get(routes::constants::get_constant))
        .layer(CorsLayer::permissive())
        .layer(TraceLayer::new_for_http());
 
    let listener = tokio::net::TcpListener::bind("127.0.0.1:3001")
        .await
        .unwrap();
 
    tracing::info!("physweb backend listening on {}", listener.local_addr().unwrap());
    axum::serve(listener, app).await.unwrap();
}
 
#[derive(Serialize)]
struct Health {
    status: &'static str,
    service: &'static str,
}
 
async fn health() -> Json<Health> {
    Json(Health { status: "ok", service: "physweb" })
}
