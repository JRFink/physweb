<script>
  let name = '';
  let email = '';
  let password = '';
  let confirm = '';
  let loading = false;
  let error = '';

  async function handleSubmit(e) {
    e.preventDefault();
    if (password !== confirm) { error = 'Passwords do not match.'; return; }
    if (password.length < 8)  { error = 'Password must be at least 8 characters.'; return; }
    loading = true;
    error = '';
    await new Promise(r => setTimeout(r, 800));
    loading = false;
    error = 'Registration not yet available. Check back soon!';
  }
</script>

<div class="auth-page">
  <div class="blob b1"></div>
  <div class="blob b2"></div>

  <div class="auth-card">
    <a href="/" class="logo">phys<span class="logo-accent">web</span></a>
    <h1>Create your account</h1>
    <p class="subtitle">Start learning physics for free. No credit card required.</p>

    {#if error}
      <div class="error-box">{error}</div>
    {/if}

    <form on:submit={handleSubmit}>
      <div class="field">
        <label for="name">Full Name</label>
        <input
          id="name"
          type="text"
          placeholder="London McAlister"
          bind:value={name}
          required
          autocomplete="name"
        />
      </div>

      <div class="field">
        <label for="email">Email</label>
        <input
          id="email"
          type="email"
          placeholder="london@mail.com"
          bind:value={email}
          required
          autocomplete="email"
        />
      </div>

      <div class="field">
        <label for="password">Password</label>
        <input
          id="password"
          type="password"
          placeholder="Min. 8 characters"
          bind:value={password}
          required
          autocomplete="new-password"
        />
      </div>

      <div class="field">
        <label for="confirm">Confirm Password</label>
        <input
          id="confirm"
          type="password"
          placeholder="Repeat your password"
          bind:value={confirm}
          required
          autocomplete="new-password"
        />
      </div>

      <button type="submit" class="submit-btn" disabled={loading}>
        {#if loading}
          <span class="spinner"></span> Creating account…
        {:else}
          Create Account
        {/if}
      </button>
    </form>

    <p class="terms">By creating an account you agree to our <a href="/terms">Terms of Service</a> and <a href="/privacy">Privacy Policy</a>.</p>
    <p class="switch-link">Already have an account? <a href="/auth/login">Sign in →</a></p>
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
    background: radial-gradient(circle, rgba(74,158,255,0.1), transparent 70%);
    top: -100px; right: -100px;
  }

  .b2 {
    width: 400px; height: 400px;
    background: radial-gradient(circle, rgba(6,214,160,0.1), transparent 70%);
    bottom: -50px; left: -50px;
  }

  .auth-card {
    position: relative;
    z-index: 1;
    width: 100%;
    max-width: 440px;
    background: var(--surface);
    border: 1px solid var(--border-bright);
    border-radius: var(--radius-lg);
    padding: 2.5rem;
    display: flex;
    flex-direction: column;
    gap: 1rem;
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
    margin: -0.25rem 0 0;
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
    gap: 0.85rem;
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
  }

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

  .terms {
    font-size: 0.75rem;
    color: var(--text-muted);
    line-height: 1.5;
  }

  .terms a {
    color: var(--text-dim);
    text-decoration: underline;
  }

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
