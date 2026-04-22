<script>
  let email = '';
  let password = '';
  let loading = false;
  let error = '';

  async function handleSubmit(e) {
    e.preventDefault();
    loading = true;
    error = '';
    // TODO: wire up to backend auth endpoint
    await new Promise(r => setTimeout(r, 800));
    loading = false;
    error = 'Authentication not yet available. Check back soon!';
  }
</script>

<div class="auth-page">
  <div class="blob b1"></div>
  <div class="blob b2"></div>

  <div class="auth-card">
    <a href="/" class="logo">phys<span class="logo-accent">web</span></a>
    <h1>Welcome back</h1>
    <p class="subtitle">Log in to continue your physics journey.</p>

    {#if error}
      <div class="error-box">{error}</div>
    {/if}

    <form on:submit={handleSubmit}>
      <div class="field">
        <label for="email">Email</label>
        <input
          id="email"
          type="email"
          placeholder="you@example.com"
          bind:value={email}
          required
          autocomplete="email"
        />
      </div>

      <div class="field">
        <label for="password">
          Password
          <a href="/auth/forgot" class="forgot">Forgot?</a>
        </label>
        <input
          id="password"
          type="password"
          placeholder="••••••••"
          bind:value={password}
          required
          autocomplete="current-password"
        />
      </div>

      <button type="submit" class="submit-btn" disabled={loading}>
        {#if loading}
          <span class="spinner"></span> Signing in…
        {:else}
          Sign In
        {/if}
      </button>
    </form>

    <p class="switch-link">Don't have an account? <a href="/auth/register">Create one →</a></p>
  </div>
</div>

<style>
  .auth-page {
    min-height: calc(100vh - var(--nav-h));
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 2rem 1rem;
    position: relative;
    overflow: hidden;
  }

  .blob {
    position: absolute;
    border-radius: 50%;
    filter: blur(100px);
    pointer-events: none;
  }

  .b1 {
    width: 500px; height: 500px;
    background: radial-gradient(circle, rgba(6,214,160,0.1), transparent 70%);
    top: -100px; left: -100px;
  }

  .b2 {
    width: 400px; height: 400px;
    background: radial-gradient(circle, rgba(168,85,247,0.1), transparent 70%);
    bottom: -50px; right: -50px;
  }

  .auth-card {
    position: relative;
    z-index: 1;
    width: 100%;
    max-width: 420px;
    background: var(--surface);
    border: 1px solid var(--border-bright);
    border-radius: var(--radius-lg);
    padding: 2.5rem;
    display: flex;
    flex-direction: column;
    gap: 1.25rem;
  }

  .logo {
    font-size: 1.2rem;
    font-weight: 700;
    letter-spacing: -0.02em;
    color: var(--text);
    text-decoration: none;
    display: block;
    margin-bottom: 0.25rem;
  }

  .logo-accent {
    background: var(--grad);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }

  h1 {
    font-size: 1.5rem;
    font-weight: 700;
    margin: 0;
  }

  .subtitle {
    font-size: 0.875rem;
    color: var(--text-dim);
    margin: -0.5rem 0 0;
  }

  .error-box {
    background: rgba(239,68,68,0.1);
    border: 1px solid rgba(239,68,68,0.3);
    color: #f87171;
    font-size: 0.85rem;
    padding: 0.75rem 1rem;
    border-radius: var(--radius);
  }

  form {
    display: flex;
    flex-direction: column;
    gap: 1rem;
  }

  .field {
    display: flex;
    flex-direction: column;
    gap: 0.4rem;
  }

  label {
    font-size: 0.82rem;
    font-weight: 500;
    color: var(--text-dim);
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .forgot {
    font-size: 0.78rem;
    color: var(--blue);
    transition: opacity 0.15s;
  }

  .forgot:hover { opacity: 0.75; }

  input {
    background: var(--surface-2);
    border: 1px solid var(--border-bright);
    border-radius: 8px;
    padding: 0.65rem 0.9rem;
    font-size: 0.9rem;
    color: var(--text);
    font-family: inherit;
    outline: none;
    transition: border-color 0.15s;
  }

  input::placeholder { color: var(--text-muted); }

  input:focus {
    border-color: var(--blue);
    box-shadow: 0 0 0 3px rgba(74,158,255,0.12);
  }

  .submit-btn {
    width: 100%;
    padding: 0.75rem;
    background: var(--grad);
    color: #fff;
    font-weight: 600;
    font-size: 0.95rem;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: opacity 0.2s;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
    margin-top: 0.25rem;
  }

  .submit-btn:disabled {
    opacity: 0.6;
    cursor: not-allowed;
  }

  .spinner {
    width: 16px; height: 16px;
    border: 2px solid rgba(255,255,255,0.3);
    border-top-color: #fff;
    border-radius: 50%;
    animation: spin 0.6s linear infinite;
    flex-shrink: 0;
  }

  @keyframes spin { to { transform: rotate(360deg); } }

  .switch-link {
    text-align: center;
    font-size: 0.85rem;
    color: var(--text-muted);
  }

  .switch-link a {
    color: var(--blue);
    transition: opacity 0.15s;
  }

  .switch-link a:hover { opacity: 0.75; }
</style>
