<script>
  import '../app.css';
  import { page } from '$app/stores';

  let menuOpen = false;

  const navLinks = [
    { href: '/learn',    label: 'Learn'    },
    { href: '/research', label: 'Research' },
    { href: '/tutoring', label: 'Tutoring' },
  ];

  let newsletterEmail = '';
  let newsletterState = 'idle'; // 'idle' | 'loading' | 'success' | 'error'
  let newsletterMsg = '';

  async function handleNewsletter(e) {
    e.preventDefault();
    newsletterState = 'loading';
    newsletterMsg = '';
    try {
      const res = await fetch('/api/subscribe', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email: newsletterEmail }),
      });
      const data = await res.json();
      if (data.success) {
        newsletterState = 'success';
        newsletterMsg = data.message;
        newsletterEmail = '';
      } else {
        newsletterState = 'error';
        newsletterMsg = data.message;
      }
    } catch {
      newsletterState = 'error';
      newsletterMsg = 'Something went wrong. Please try again.';
    }
  }
</script>

<nav class="nav">
  <div class="nav-inner">
    <a href="/" class="logo">
      phys<span class="logo-accent">web</span>
    </a>

    <div class="nav-links" class:open={menuOpen}>
      {#each navLinks as link}
        <a
          href={link.href}
          class="nav-link"
          class:active={$page.url.pathname.startsWith(link.href)}
          on:click={() => menuOpen = false}
        >{link.label}</a>
      {/each}
    </div>

    <div class="nav-actions">
      <a href="/auth/login" class="nav-auth-link">Log in</a>
      <a href="/auth/register" class="btn-primary nav-cta">Get Started</a>
    </div>

    <button class="hamburger" on:click={() => menuOpen = !menuOpen} aria-label="Toggle menu">
      <span class:open={menuOpen}></span>
      <span class:open={menuOpen}></span>
      <span class:open={menuOpen}></span>
    </button>
  </div>
</nav>

<main>
  <slot />
</main>

<footer class="footer">
  <div class="container">
    <div class="footer-top">
      <div class="footer-brand">
        <a href="/" class="logo">phys<span class="logo-accent">web</span></a>
        <p>The complete physics learning and research platform.</p>
      </div>
      <div class="footer-cols">
        <div class="footer-col">
          <h4>Learn</h4>
          <a href="/learn">All Modules</a>
          <a href="/learn">General Physics</a>
          <a href="/learn">Quantum Mechanics</a>
          <a href="/learn">Special Relativity</a>
        </div>
        <div class="footer-col">
          <h4>Research</h4>
          <a href="/research">All Areas</a>
          <a href="/research">Particle Physics</a>
          <a href="/research">Condensed Matter</a>
          <a href="/research">Astrophysics</a>
        </div>
        <div class="footer-col">
          <h4>Platform</h4>
          <a href="/tutoring">Tutoring</a>
          <a href="/auth/register">Sign Up</a>
          <a href="/auth/login">Log In</a>
        </div>
      </div>
    </div>
    <div class="newsletter">
      <div class="newsletter-text">
        <h4>Stay in the loop</h4>
        <p>New modules, research updates, and platform news.</p>
      </div>
      {#if newsletterState === 'success'}
        <div class="newsletter-success">{newsletterMsg}</div>
      {:else}
        <form class="newsletter-form" on:submit={handleNewsletter}>
          <input
            type="email"
            placeholder="london@mail.com"
            bind:value={newsletterEmail}
            required
            disabled={newsletterState === 'loading'}
          />
          <button type="submit" disabled={newsletterState === 'loading'}>
            {newsletterState === 'loading' ? '…' : 'Subscribe'}
          </button>
        </form>
        {#if newsletterState === 'error'}
          <p class="newsletter-error">{newsletterMsg}</p>
        {/if}
      {/if}
    </div>

    <div class="footer-bottom">
      <span>© 2026 Physweb. All rights reserved.</span>
    </div>
  </div>
</footer>

<style>
  .nav {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 100;
    height: var(--nav-h);
    background: rgba(6, 11, 20, 0.85);
    backdrop-filter: blur(16px);
    -webkit-backdrop-filter: blur(16px);
    border-bottom: 1px solid var(--border);
  }

  .nav-inner {
    max-width: var(--max-w);
    margin: 0 auto;
    padding: 0 1.5rem;
    height: 100%;
    display: flex;
    align-items: center;
    gap: 2rem;
  }

  .logo {
    font-size: 1.3rem;
    font-weight: 700;
    letter-spacing: -0.02em;
    color: var(--text);
    flex-shrink: 0;
  }

  .logo-accent {
    background: var(--grad);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }

  .nav-links {
    display: flex;
    align-items: center;
    gap: 0.25rem;
    flex: 1;
  }

  .nav-link {
    padding: 0.4rem 0.85rem;
    font-size: 0.9rem;
    font-weight: 500;
    color: var(--text-dim);
    border-radius: 8px;
    transition: color 0.15s, background 0.15s;
  }

  .nav-link:hover,
  .nav-link.active {
    color: var(--text);
    background: var(--surface-2);
  }

  .nav-actions {
    display: flex;
    align-items: center;
    gap: 1rem;
    margin-left: auto;
  }

  .nav-auth-link {
    font-size: 0.9rem;
    font-weight: 500;
    color: var(--text-dim);
    transition: color 0.15s;
  }

  .nav-auth-link:hover {
    color: var(--text);
  }

  .nav-cta {
    font-size: 0.85rem;
    padding: 0.5rem 1.25rem;
  }

  .hamburger {
    display: none;
    flex-direction: column;
    gap: 5px;
    background: none;
    border: none;
    padding: 0.25rem;
    margin-left: auto;
  }

  .hamburger span {
    display: block;
    width: 22px;
    height: 2px;
    background: var(--text-dim);
    border-radius: 2px;
    transition: transform 0.25s, opacity 0.25s;
    transform-origin: center;
  }

  .hamburger span:nth-child(1).open { transform: translateY(7px) rotate(45deg); }
  .hamburger span:nth-child(2).open { opacity: 0; }
  .hamburger span:nth-child(3).open { transform: translateY(-7px) rotate(-45deg); }

  main {
    padding-top: var(--nav-h);
    min-height: 100vh;
  }

  /* Footer */
  .footer {
    background: var(--surface);
    border-top: 1px solid var(--border);
    padding: 3rem 0 1.5rem;
    margin-top: 4rem;
  }

  .footer-top {
    display: flex;
    gap: 4rem;
    margin-bottom: 2.5rem;
  }

  .footer-brand {
    flex: 1;
    min-width: 0;
  }

  .footer-brand p {
    margin-top: 0.75rem;
    font-size: 0.9rem;
    color: var(--text-muted);
    max-width: 260px;
    line-height: 1.6;
  }

  .footer-cols {
    display: flex;
    gap: 3rem;
    flex-shrink: 0;
  }

  .footer-col {
    display: flex;
    flex-direction: column;
    gap: 0.6rem;
  }

  .footer-col h4 {
    font-size: 0.8rem;
    font-weight: 600;
    letter-spacing: 0.08em;
    text-transform: uppercase;
    color: var(--text-dim);
    margin-bottom: 0.25rem;
  }

  .footer-col a {
    font-size: 0.875rem;
    color: var(--text-muted);
    transition: color 0.15s;
  }

  .footer-col a:hover {
    color: var(--text);
  }

  .newsletter {
    display: flex;
    align-items: center;
    gap: 2rem;
    padding: 1.5rem 0;
    border-top: 1px solid var(--border);
    border-bottom: 1px solid var(--border);
    margin-bottom: 1.5rem;
    flex-wrap: wrap;
  }

  .newsletter-text {
    flex: 1;
    min-width: 160px;
  }

  .newsletter-text h4 {
    font-size: 0.9rem;
    font-weight: 600;
    color: var(--text);
    margin-bottom: 0.2rem;
  }

  .newsletter-text p {
    font-size: 0.8rem;
    color: var(--text-muted);
  }

  .newsletter-form {
    display: flex;
    gap: 0.5rem;
    flex: 2;
    min-width: 260px;
  }

  .newsletter-form input {
    flex: 1;
    background: var(--surface-2);
    border: 1px solid var(--border-bright);
    border-radius: 8px;
    padding: 0.55rem 0.85rem;
    font-size: 0.875rem;
    color: var(--text);
    font-family: inherit;
    outline: none;
    transition: border-color 0.15s;
    min-width: 0;
  }

  .newsletter-form input::placeholder { color: var(--text-muted); }

  .newsletter-form input:focus {
    border-color: var(--blue);
    box-shadow: 0 0 0 3px rgba(74,158,255,0.1);
  }

  .newsletter-form button {
    padding: 0.55rem 1.25rem;
    background: var(--grad);
    color: #fff;
    font-weight: 600;
    font-size: 0.85rem;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    white-space: nowrap;
    transition: opacity 0.2s;
    flex-shrink: 0;
  }

  .newsletter-form button:disabled {
    opacity: 0.6;
    cursor: not-allowed;
  }

  .newsletter-success {
    font-size: 0.875rem;
    color: var(--green);
    flex: 2;
  }

  .newsletter-error {
    font-size: 0.78rem;
    color: #f87171;
    margin-top: 0.35rem;
    width: 100%;
  }

  .footer-bottom {
    border-top: 1px solid var(--border);
    padding-top: 1.5rem;
    font-size: 0.8rem;
    color: var(--text-muted);
  }

  @media (max-width: 768px) {
    .nav-links {
      position: fixed;
      top: var(--nav-h);
      left: 0;
      right: 0;
      background: var(--surface);
      border-bottom: 1px solid var(--border);
      flex-direction: column;
      align-items: flex-start;
      padding: 1rem 1.5rem;
      gap: 0.25rem;
      display: none;
    }

    .nav-links.open {
      display: flex;
    }

    .nav-actions {
      display: none;
    }

    .hamburger {
      display: flex;
    }

    .footer-top {
      flex-direction: column;
      gap: 2rem;
    }

    .footer-cols {
      gap: 2rem;
      flex-wrap: wrap;
    }
  }
</style>
