<script>
  import { onMount } from 'svelte';

  const words = ['students', 'researchers', 'ai models', 'engineers'];
  let trackEl;
  let wrapperEl;
  let isAnimating = false;
  let wrapperWidth = 0;
  let current = 0;

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
    if (isAnimating || !trackEl || !wrapperEl) return;
    isAnimating = true;

    const next = (current + 1) % words.length;
    const wordH = wrapperEl.offsetHeight;

    // Phase 1: slide current word down and out of view
    trackEl.style.transition = 'transform 0.3s cubic-bezier(0.55, 0, 1, 0.45)';
    trackEl.style.transform = `translateY(${wordH}px)`;

    setTimeout(() => {
      // Jump: position next word above the viewport (no transition)
      trackEl.style.transition = 'none';
      trackEl.style.transform = `translateY(${-next * wordH - wordH}px)`;

      // Force reflow
      trackEl.getBoundingClientRect();

      // Phase 2: slide down into view, overshoot slightly
      const targetY = -next * wordH;
      const overshoot = targetY + wordH * 0.12;

      trackEl.style.transition = 'transform 0.32s cubic-bezier(0.22, 1, 0.36, 1)';
      trackEl.style.transform = `translateY(${overshoot}px)`;

      setTimeout(() => {
        // Phase 3: snap back up to exact position (the shake/click)
        trackEl.style.transition = 'transform 0.18s cubic-bezier(0.34, 1.56, 0.64, 1)';
        trackEl.style.transform = `translateY(${targetY}px)`;

        setTimeout(() => {
          current = next;
          isAnimating = false;
        }, 200);
      }, 340);
    }, 310);
  }

  onMount(() => {
    measureWords();
    window.addEventListener('resize', measureWords);
    const interval = setInterval(animateNext, 2400);
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
  </div>
</main>

<style>
  :global(*, *::before, *::after) { box-sizing: border-box; margin: 0; padding: 0; }
  :global(body) {
    background: #dcf7ee;
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
      rgba(207, 222, 213, 0.012) 3px,
      rgba(197, 206, 240, 0.012) 4px
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

  .cryptex-track {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
  }

  .cryptex-word {
    font-size: clamp(1.4rem, 4vw, 2.2rem);
    font-weight: 500;
    color: #1a7a4a;
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
    background: #1a7a4a;
    opacity: 0.35;
  }
</style>