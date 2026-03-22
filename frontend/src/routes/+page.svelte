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
    span.style.cssText = `font-family: 'DM Mono', monospace; font-size: clamp(1.4rem, 4vw, 2.2rem); font-weight: 500; white-space: nowrap; position: absolute; visibility: hidden; line-height: 1;`;
    document.body.appendChild(span);
    let maxW = 0;
    words.forEach(w => { span.textContent = w; maxW = Math.max(maxW, span.offsetWidth); });
    document.body.removeChild(span);
    wrapperWidth = maxW + 4;
  }

  function animateNext() {
    if (isAnimating || !trackEl || !wrapperEl) return;
    isAnimating = true;

    const next = (current + 1) % words.length;
    const wordH = wrapperEl.offsetHeight;

    // Phase 1: exit — current word slides down and out
    trackEl.style.transition = 'transform 0.28s cubic-bezier(0.4, 0, 1, 1)';
    trackEl.style.transform = `translateY(${wordH * 1.5}px)`;

    setTimeout(() => {
      // Instant jump: place next word above the wrapper
      trackEl.style.transition = 'none';
      trackEl.style.transform = `translateY(${-next * wordH - wordH * 1.5}px)`;
      trackEl.getBoundingClientRect(); // force reflow

      // Phase 2: enter — slide down, overshoot past center
      const targetY = -(next * wordH);
      trackEl.style.transition = 'transform 0.3s cubic-bezier(0.22, 1, 0.36, 1)';
      trackEl.style.transform = `translateY(${targetY + wordH * 0.1}px)`;

      setTimeout(() => {
        // Phase 3: snap back up into exact position
        trackEl.style.transition = 'transform 0.15s cubic-bezier(0.34, 1.7, 0.64, 1)';
        trackEl.style.transform = `translateY(${targetY}px)`;

        setTimeout(() => {
          current = next;
          isAnimating = false;
        }, 180);
      }, 320);
    }, 300);
  }

  onMount(() => {
    measureWords();
    // Set initial position to show first word
    if (trackEl) {
      trackEl.style.transition = 'none';
      trackEl.style.transform = 'translateY(0px)';
    }
    window.addEventListener('resize', measureWords);
    const interval = setInterval(animateNext, 2600);
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
      <span class="static-text">Physics data for&nbsp;</span>
      <div class="cryptex-wrapper" bind:this={wrapperEl} style="width: {wrapperWidth}px">
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
      transparent,
      transparent 3px,
      rgba(207, 222, 213, 0.015) 3px,
      rgba(207, 222, 213, 0.015) 4px
    );
    pointer-events: none;
  }

  .content {
    position: relative;
    z-index: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 2rem;
  }

  .headline {
    display: flex;
    align-items: center;
    flex-wrap: nowrap;
  }

  .static-text {
    font-size: clamp(1.4rem, 4vw, 2.2rem);
    font-weight: 300;
    color: #6a8f7a;
    white-space: nowrap;
    letter-spacing: -0.01em;
    line-height: 1;
  }

  .cryptex-wrapper {
    display: inline-block;
    overflow: hidden;
    /* height matches exactly one word — set by the word's own line-height */
    height: 1em;
    line-height: 1;
    position: relative;
    vertical-align: middle;
  }

  </style>