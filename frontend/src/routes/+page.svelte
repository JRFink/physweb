<script>
  import { onMount } from 'svelte';

  const words = ['students', 'researchers', 'ai models', 'engineers'];
  let current = 0;
  let phase = 'idle';
  let wordSlotWidth = 0;

  // Scroll fade state
  let heroProgress = 0; // 0 = fully visible, 1 = fully faded
  let heroEl;

  function measureMaxWidth() {
    const span = document.createElement('span');
    span.style.cssText = `font-family: 'DM Mono', monospace; font-size: clamp(1rem, 5vw, 2.2rem); font-weight: 300; white-space: nowrap; position: absolute; visibility: hidden;`;
    document.body.appendChild(span);
    let maxW = 0;
    words.forEach(w => { span.textContent = w; maxW = Math.max(maxW, span.offsetWidth); });
    document.body.removeChild(span);
    wordSlotWidth = maxW;
  }

  function tick() {
    phase = 'exit';
    setTimeout(() => {
      current = (current + 1) % words.length;
      phase = 'enter';
      setTimeout(() => { phase = 'idle'; }, 450);
    }, 350);
  }

  function onScroll() {
    // Progress 0→1 over the first 60% of the hero height
    const scrollY = window.scrollY;
    const heroH = window.innerHeight;
    heroProgress = Math.min(1, scrollY / (heroH * 0.6));
  }

  onMount(() => {
    measureMaxWidth();
    window.addEventListener('resize', measureMaxWidth);
    window.addEventListener('scroll', onScroll, { passive: true });
    const interval = setInterval(tick, 2600);
    return () => {
      clearInterval(interval);
      window.removeEventListener('resize', measureMaxWidth);
      window.removeEventListener('scroll', onScroll);
    };
  });

  $: heroOpacity = 1 - heroProgress;
  $: heroScale = 1 - heroProgress * 0.12;
  $: heroBlur = heroProgress * 6;
</script>

<!-- Hero: sticky so it stays pinned while content scrolls up over it -->
<section class="hero" bind:this={heroEl}>
  <div class="grid-bg"></div>
  <div class="scanlines"></div>

  <div
    class="hero-content"
    style="opacity: {heroOpacity}; transform: scale({heroScale}); filter: blur({heroBlur}px);"
  >
    <div class="headline">
      <span class="static-text">Physics data for&nbsp;</span>
      <span class="cryptex-slot" style="width: {wordSlotWidth}px">
        <span
          class="cryptex-word"
          class:exit={phase === 'exit'}
          class:enter={phase === 'enter'}
        >{words[current]}</span>
      </span>
    </div>

    <div class="scroll-hint">
      <span>scroll</span>
      <div class="scroll-arrow"></div>
    </div>
  </div>
</section>

<!-- Content: sits below hero in normal flow, slides up over it -->
<section class="content-section">
  <nav class="navbar">
    <span class="nav-logo">physweb</span>
    <div class="nav-links">
      <a href="/constants">Constants</a>
      <a href="/equations">Equations</a>
      <a href="/units">Units</a>
      <a href="/about">About</a>
    </div>
  </nav>

  <div class="content-body">
    <h2 class="section-heading">The physics reference you actually need</h2>
    <p class="section-sub">Precise, citable data for every domain of physics — from fundamental constants to field equations.</p>

    <div class="card-grid">
      <div class="card">
        <div class="card-icon">c</div>
        <div class="card-label">Constants</div>
        <div class="card-desc">CODATA values with full uncertainty budgets</div>
      </div>
      <div class="card">
        <div class="card-icon">∇</div>
        <div class="card-label">Equations</div>
        <div class="card-desc">Rendered, searchable, with derivations</div>
      </div>
      <div class="card">
        <div class="card-icon">SI</div>
        <div class="card-label">Units</div>
        <div class="card-desc">Full SI system with conversion factors</div>
      </div>
      <div class="card">
        <div class="card-icon">AI</div>
        <div class="card-label">API</div>
        <div class="card-desc">Machine-readable endpoints for models and tools</div>
      </div>
    </div>
  </div>
</section>

<style>
  :global(*, *::before, *::after) { box-sizing: border-box; margin: 0; padding: 0; }
  :global(body) {
    background: #ebf6f3;
    font-family: 'DM Mono', monospace;
    overflow-x: hidden;
  }

  /* ── Hero ── */
  .hero {
    position: sticky;
    top: 0;
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    z-index: 0;
  }

  .grid-bg {
    position: absolute;
    inset: 0;
    background-image:
      linear-gradient(rgba(80,200,120,0.06) 1px, transparent 1px),
      linear-gradient(90deg, rgba(80,200,120,0.06) 1px, transparent 1px);
    background-size: 40px 40px;
    pointer-events: none;
  }

  .scanlines {
    position: absolute;
    inset: 0;
    background: repeating-linear-gradient(
      0deg,
      transparent, transparent 3px,
      rgba(207,222,213,0.015) 3px, rgba(207,222,213,0.015) 4px
    );
    pointer-events: none;
  }

  .hero-content {
    position: relative;
    z-index: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 3rem;
    padding: 2rem 1.5rem;
    width: 100%;
    will-change: opacity, transform, filter;
    transform-origin: center center;
  }

  .headline {
    display: flex;
    align-items: baseline;
    flex-wrap: nowrap;
    max-width: 100%;
    overflow: hidden;
  }

  .static-text {
    font-size: clamp(1rem, 5vw, 2.2rem);
    font-weight: 300;
    color: #6a8f7a;
    white-space: nowrap;
    letter-spacing: -0.01em;
    flex-shrink: 0;
  }

  .cryptex-slot {
    display: inline-block;
    overflow: hidden;
    flex-shrink: 0;
    clip-path: inset(-50% 0 -50% 0);
  }

  .cryptex-word {
    font-size: clamp(1rem, 5vw, 2.2rem);
    font-weight: 300;
    color: #1a7a4a;
    white-space: nowrap;
    letter-spacing: -0.01em;
    display: inline-block;
    transform: translateY(0);
    opacity: 1;
    transition: none;
  }

  .cryptex-word.exit {
    transform: translateY(120%);
    opacity: 0;
    transition: transform 0.32s cubic-bezier(0.4,0,1,0.6), opacity 0.25s ease;
  }

  .cryptex-word.enter {
    animation: enterWord 0.42s cubic-bezier(0.22,1,0.36,1) forwards;
  }

  @keyframes enterWord {
    0%   { transform: translateY(-130%); opacity: 0; }
    60%  { transform: translateY(8%);    opacity: 1; }
    80%  { transform: translateY(-3%);   opacity: 1; }
    100% { transform: translateY(0);     opacity: 1; }
  }

  .scroll-hint {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 6px;
    opacity: 0.4;
    font-size: 11px;
    letter-spacing: 0.2em;
    color: #4a7c55;
    text-transform: uppercase;
  }

  .scroll-arrow {
    width: 1px;
    height: 28px;
    background: linear-gradient(to bottom, #4a7c55, transparent);
    animation: arrowPulse 1.8s ease-in-out infinite;
  }

  @keyframes arrowPulse {
    0%, 100% { opacity: 0.3; transform: scaleY(1); }
    50%       { opacity: 0.8; transform: scaleY(1.15); }
  }

  /* ── Content section ── */
  .content-section {
    position: relative;
    z-index: 1;
    background: #ebf6f3;
    min-height: 100vh;
    border-top: 1px solid rgba(80,200,120,0.15);
    box-shadow: 0 -8px 40px rgba(0,0,0,0.06);
  }

  .navbar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 1.5rem 3rem;
    border-bottom: 1px solid rgba(80,200,120,0.12);
  }

  .nav-logo {
    font-size: 1rem;
    font-weight: 500;
    color: #1a7a4a;
    letter-spacing: 0.05em;
  }

  .nav-links {
    display: flex;
    gap: 2.5rem;
  }

  .nav-links a {
    font-size: 0.85rem;
    font-weight: 300;
    color: #6a8f7a;
    text-decoration: none;
    letter-spacing: 0.05em;
    transition: color 0.2s;
  }

  .nav-links a:hover {
    color: #1a7a4a;
  }

  .content-body {
    max-width: 900px;
    margin: 0 auto;
    padding: 5rem 2rem;
    display: flex;
    flex-direction: column;
    gap: 3rem;
  }

  .section-heading {
    font-size: clamp(1.4rem, 3vw, 2rem);
    font-weight: 300;
    color: #2a4a38;
    letter-spacing: -0.02em;
    line-height: 1.3;
  }

  .section-sub {
    font-size: 0.95rem;
    color: #6a8f7a;
    line-height: 1.7;
    max-width: 540px;
  }

  .card-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 1.5rem;
  }

  .card {
    background: rgba(255,255,255,0.6);
    border: 1px solid rgba(80,200,120,0.18);
    border-radius: 8px;
    padding: 1.5rem;
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
    transition: border-color 0.2s, background 0.2s;
  }

  .card:hover {
    background: rgba(255,255,255,0.9);
    border-color: rgba(80,200,120,0.4);
  }

  .card-icon {
    font-size: 1.2rem;
    font-weight: 500;
    color: #1a7a4a;
    font-style: italic;
  }

  .card-label {
    font-size: 0.9rem;
    font-weight: 500;
    color: #2a4a38;
    letter-spacing: 0.05em;
  }

  .card-desc {
    font-size: 0.8rem;
    color: #6a8f7a;
    line-height: 1.5;
  }

  @media (max-width: 600px) {
    .navbar {
      padding: 1.25rem 1.5rem;
    }
    .nav-links {
      gap: 1.5rem;
    }
    .nav-links a {
      font-size: 0.78rem;
    }
  }
</style>
