set -e
BASE="/home/jefffink/projects/physweb"
mkdir -p "$BASE"
cd "$BASE"
 
# ─── Rust backend ────────────────────────────────────────────────────────────
mkdir -p backend/src/routes
 
cat > backend/Cargo.toml << 'EOF'
[package]
name = "physweb"
version = "0.1.0"
edition = "2021"
 
[dependencies]
axum = { version = "0.7", features = ["macros"] }
tokio = { version = "1", features = ["full"] }
tower = "0.4"
tower-http = { version = "0.5", features = ["cors", "fs", "trace"] }
serde = { version = "1", features = ["derive"] }
serde_json = "1"
tracing = "0.1"
tracing-subscriber = { version = "0.3", features = ["env-filter"] }
EOF
 
cat > backend/src/main.rs << 'EOF'
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
EOF
 
cat > backend/src/routes/mod.rs << 'EOF'
pub mod constants;
EOF
 
cat > backend/src/routes/constants.rs << 'EOF'
use axum::{extract::Path, Json, http::StatusCode};
use serde::Serialize;
 
#[derive(Serialize, Clone)]
pub struct PhysicsConstant {
    pub symbol: String,
    pub name: String,
    pub value: f64,
    pub unit: String,
    pub category: String,
    pub description: String,
}
 
fn all_constants() -> Vec<PhysicsConstant> {
    vec![
        PhysicsConstant {
            symbol: "c".into(),
            name: "Speed of light".into(),
            value: 299_792_458.0,
            unit: "m/s".into(),
            category: "electromagnetic".into(),
            description: "Speed of light in a vacuum".into(),
        },
        PhysicsConstant {
            symbol: "h".into(),
            name: "Planck constant".into(),
            value: 6.626_070_15e-34,
            unit: "J·s".into(),
            category: "quantum".into(),
            description: "Relates photon energy to its frequency".into(),
        },
        PhysicsConstant {
            symbol: "G".into(),
            name: "Gravitational constant".into(),
            value: 6.674_30e-11,
            unit: "m³/(kg·s²)".into(),
            category: "gravitational".into(),
            description: "Proportionality constant in Newton's law of gravitation".into(),
        },
        PhysicsConstant {
            symbol: "e".into(),
            name: "Elementary charge".into(),
            value: 1.602_176_634e-19,
            unit: "C".into(),
            category: "electromagnetic".into(),
            description: "Electric charge carried by a single proton".into(),
        },
        PhysicsConstant {
            symbol: "k_B".into(),
            name: "Boltzmann constant".into(),
            value: 1.380_649e-23,
            unit: "J/K".into(),
            category: "thermodynamic".into(),
            description: "Relates particle kinetic energy to temperature".into(),
        },
        PhysicsConstant {
            symbol: "N_A".into(),
            name: "Avogadro constant".into(),
            value: 6.022_140_76e23,
            unit: "mol⁻¹".into(),
            category: "thermodynamic".into(),
            description: "Number of constituent particles per mole".into(),
        },
        PhysicsConstant {
            symbol: "epsilon_0".into(),
            name: "Vacuum permittivity".into(),
            value: 8.854_187_812_8e-12,
            unit: "F/m".into(),
            category: "electromagnetic".into(),
            description: "Permittivity of free space".into(),
        },
        PhysicsConstant {
            symbol: "mu_0".into(),
            name: "Vacuum permeability".into(),
            value: 1.256_637_062_12e-6,
            unit: "H/m".into(),
            category: "electromagnetic".into(),
            description: "Permeability of free space".into(),
        },
    ]
}
 
pub async fn list_constants() -> Json<Vec<PhysicsConstant>> {
    Json(all_constants())
}
 
pub async fn get_constant(
    Path(symbol): Path<String>,
) -> Result<Json<PhysicsConstant>, StatusCode> {
    all_constants()
        .into_iter()
        .find(|c| c.symbol == symbol)
        .map(Json)
        .ok_or(StatusCode::NOT_FOUND)
}
EOF
 
# ─── SvelteKit frontend ───────────────────────────────────────────────────────
mkdir -p frontend/src/routes frontend/src/lib frontend/static
 
cat > frontend/package.json << 'EOF'
{
  "name": "physweb-frontend",
  "version": "0.0.1",
  "private": true,
  "scripts": {
    "dev": "vite dev",
    "build": "vite build",
    "preview": "vite preview"
  },
  "devDependencies": {
    "@sveltejs/adapter-node": "^5.0.0",
    "@sveltejs/kit": "^2.0.0",
    "svelte": "^5.0.0",
    "vite": "^5.0.0"
  }
}
EOF
 
cat > frontend/svelte.config.js << 'EOF'
import adapter from '@sveltejs/adapter-node';
 
/** @type {import('@sveltejs/kit').Config} */
const config = {
    kit: {
        adapter: adapter({ out: 'build' }),
    },
};
 
export default config;
EOF
 
cat > frontend/vite.config.js << 'EOF'
import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';
 
export default defineConfig({
    plugins: [sveltekit()],
    server: {
        proxy: {
            '/api': 'http://127.0.0.1:3001',
        },
    },
});
EOF
 
cat > frontend/src/app.html << 'EOF'
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <link rel="icon" href="%sveltekit.assets%/favicon.png" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="description" content="Physics reference data for students, researchers, AI models, and engineers." />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous" />
        <link href="https://fonts.googleapis.com/css2?family=DM+Mono:wght@300;400;500&display=swap" rel="stylesheet" />
        %sveltekit.head%
    </head>
    <body data-sveltekit-preload-data="hover">
        <div style="display: contents">%sveltekit.body%</div>
    </body>
</html>
EOF
 
cat > frontend/src/routes/+page.svelte << 'SVELTE'
<script>
  import { onMount } from 'svelte';
 
  const words = ['students', 'researchers', 'ai models', 'engineers'];
  let current = 0;
  let trackEl;
  let wrapperEl;
  let isAnimating = false;
  let wrapperWidth = 0;
 
  function measureWords() {
    const span = document.createElement('span');
    span.style.cssText = `font-family: 'DM Mono', monospace; font-size: clamp(1.4rem, 4vw, 2.2rem); font-weight: 500; white-space: nowrap; position: absolute; visibility: hidden;`;
    document.body.appendChild(span);
    let maxW = 0;
    words.forEach(w => { span.textContent = w; maxW = Math.max(maxW, span.offsetWidth); });
    document.body.removeChild(span);
    wrapperWidth = maxW + 8;
  }
 
  function animateNext() {
    if (isAnimating || !trackEl) return;
    isAnimating = true;
    const next = (current + 1) % words.length;
    const wordH = wrapperEl.offsetHeight;
    const targetY = -(next * wordH);
    const overshoot = targetY - wordH * 0.28;
 
    trackEl.style.transition = `transform 0.38s cubic-bezier(0.32, 0, 0.67, 0)`;
    trackEl.style.transform = `translateY(${overshoot}px)`;
 
    setTimeout(() => {
      trackEl.style.transition = `transform 0.22s cubic-bezier(0.34, 1.56, 0.64, 1)`;
      trackEl.style.transform = `translateY(${targetY}px)`;
      setTimeout(() => { current = next; isAnimating = false; }, 240);
    }, 390);
  }
 
  onMount(() => {
    measureWords();
    window.addEventListener('resize', measureWords);
    const interval = setInterval(animateNext, 2200);
    return () => {
      clearInterval(interval);
      window.removeEventListener('resize', measureWords);
    };
  });
</script>
 
<main>
  <div class="grid-bg"></div>
  <div class="scanlines"></div>
 
  <div class="content">
    <span class="label">physweb.com — beta</span>
 
    <div class="headline">
      <span class="static-text">Physics data for</span>
      <div
        class="cryptex-wrapper"
        bind:this={wrapperEl}
        style="width: {wrapperWidth}px"
      >
        <div class="cryptex-track" bind:this={trackEl}>
          {#each words as word}
            <div class="cryptex-word">{word}</div>
          {/each}
        </div>
      </div>
    </div>
 
    <div class="ticker-line"></div>
    <span class="sub">[ initializing data streams ]</span>
  </div>
</main>
 
<style>
  :global(*, *::before, *::after) { box-sizing: border-box; margin: 0; padding: 0; }
  :global(body) {
    background: #0a0d0f;
    color: #c8d8c0;
    font-family: 'DM Mono', monospace;
  }
 
  main {
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    overflow: hidden;
  }
 
  .grid-bg {
    position: absolute;
    inset: 0;
    background-image:
      linear-gradient(rgba(80,200,120,0.04) 1px, transparent 1px),
      linear-gradient(90deg, rgba(80,200,120,0.04) 1px, transparent 1px);
    background-size: 40px 40px;
    pointer-events: none;
  }
 
  .scanlines {
    position: absolute;
    inset: 0;
    background: repeating-linear-gradient(
      0deg,
      transparent,
      transparent 3px,
      rgba(0,255,100,0.012) 3px,
      rgba(0,255,100,0.012) 4px
    );
    pointer-events: none;
  }
 
  .content {
    position: relative;
    z-index: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 2.5rem;
  }
 
  .label {
    font-size: 11px;
    font-weight: 400;
    letter-spacing: 0.25em;
    color: #4a7c55;
    text-transform: uppercase;
  }
 
  .headline {
    display: flex;
    align-items: center;
    flex-wrap: nowrap;
  }
 
  .static-text {
    font-size: clamp(1.4rem, 4vw, 2.2rem);
    font-weight: 300;
    color: #b8ccb0;
    white-space: nowrap;
    letter-spacing: -0.01em;
  }
 
  .cryptex-wrapper {
    display: inline-block;
    overflow: hidden;
    height: 1.35em;
    position: relative;
    vertical-align: middle;
    margin-left: 0.25em;
  }
 
  .cryptex-wrapper::before,
  .cryptex-wrapper::after {
    content: '';
    position: absolute;
    left: 0; right: 0;
    height: 30%;
    z-index: 2;
    pointer-events: none;
  }
  .cryptex-wrapper::before {
    top: 0;
    background: linear-gradient(to bottom, #0a0d0f 0%, transparent 100%);
  }
  .cryptex-wrapper::after {
    bottom: 0;
    background: linear-gradient(to top, #0a0d0f 0%, transparent 100%);
  }
 
  .cryptex-track {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
  }
 
  .cryptex-word {
    font-size: clamp(1.4rem, 4vw, 2.2rem);
    font-weight: 500;
    color: #52d98a;
    white-space: nowrap;
    line-height: 1.35;
    height: 1.35em;
    letter-spacing: -0.01em;
    display: flex;
    align-items: center;
  }
 
  .ticker-line {
    width: 48px;
    height: 1px;
    background: #52d98a;
    opacity: 0.35;
  }
 
  .sub {
    font-size: 12px;
    color: #3a5a42;
    letter-spacing: 0.15em;
  }
</style>
SVELTE
 
# ─── GitHub Actions CI/CD ─────────────────────────────────────────────────────
mkdir -p .github/workflows
 
cat > .github/workflows/deploy.yml << 'EOF'
name: Deploy physweb
 
on:
  push:
    branches: [main]
 
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
 
      - name: Build frontend
        working-directory: frontend
        run: |
          npm ci
          npm run build
 
      - name: Deploy to EC2
        uses: appleboy/ssh-action@v1.0.3
        with:
          host: ${{ secrets.PHYSWEB_HOST }}
          username: ubuntu
          key: ${{ secrets.PHYSWEB_SSH_KEY }}
          script: |
            cd /var/www/physweb
            git pull origin main
            cd frontend && npm ci && npm run build
            cd ../backend && cargo build --release
            sudo systemctl restart physweb-backend
            sudo systemctl restart physweb-frontend
EOF
 
# ─── Nginx config (deploy to EC2 at /etc/nginx/sites-available/physweb) ──────
cat > nginx.conf << 'EOF'
server {
    listen 80;
    server_name physweb.com www.physweb.com;
    return 301 https://$host$request_uri;
}
 
server {
    listen 443 ssl;
    server_name physweb.com www.physweb.com;
 
    ssl_certificate     /etc/letsencrypt/live/physweb.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/physweb.com/privkey.pem;
 
    # API — Rust/Axum backend
    location /api/ {
        proxy_pass http://127.0.0.1:3001;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
 
    # Frontend — SvelteKit node server
    location / {
        proxy_pass http://127.0.0.1:3002;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
    }
}
EOF
 
# ─── systemd services (copy to /etc/systemd/system/ on EC2) ──────────────────
cat > physweb-backend.service << 'EOF'
[Unit]
Description=physweb Rust backend
After=network.target
 
[Service]
User=ubuntu
WorkingDirectory=/var/www/physweb/backend
ExecStart=/var/www/physweb/backend/target/release/physweb
Restart=on-failure
RestartSec=5
Environment=RUST_LOG=physweb=info,tower_http=info
 
[Install]
WantedBy=multi-user.target
EOF
 
cat > physweb-frontend.service << 'EOF'
[Unit]
Description=physweb SvelteKit frontend
After=network.target
 
[Service]
User=ubuntu
WorkingDirectory=/var/www/physweb/frontend
ExecStart=/usr/bin/node build
Restart=on-failure
RestartSec=5
Environment=PORT=3002
Environment=HOST=127.0.0.1
 
[Install]
WantedBy=multi-user.target
EOF
 
# ─── .gitignore ───────────────────────────────────────────────────────────────
cat > .gitignore << 'EOF'
# Rust
backend/target/
 
# SvelteKit
frontend/.svelte-kit/
frontend/build/
frontend/node_modules/
 
# Misc
.env
*.env.local
EOF
 
echo ""
echo "✓ physweb scaffold complete."
echo ""
echo "Next steps:"
echo "  1. cd /home/jefffink/projects/physweb/frontend && npm install"
echo "  2. cd ../backend && cargo build"
echo "  3. git init && git add . && git commit -m 'initial scaffold'"
echo "  4. Push to GitHub, set PHYSWEB_HOST + PHYSWEB_SSH_KEY secrets"
echo "  5. On EC2: sudo cp nginx.conf /etc/nginx/sites-available/physweb"
echo "             sudo ln -s /etc/nginx/sites-available/physweb /etc/nginx/sites-enabled/"
echo "             sudo certbot --nginx -d physweb.com"
echo "             sudo cp physweb-*.service /etc/systemd/system/"
echo "             sudo systemctl enable --now physweb-backend physweb-frontend"