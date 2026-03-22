<script>
  import { onMount } from 'svelte';

  const words = ['students', 'researchers', 'ai models', 'engineers'];
  let current = 0;
  let phase = 'idle';
  let wordSlotWidth = 0;

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

  onMount(() => {
    measureMaxWidth();
    window.addEventListener('resize', measureMaxWidth);
    const interval = setInterval(tick, 2600);
    return () => {
      clearInterval(interval);
      window.removeEventListener('resize', measureMaxWidth);
    };
  });
</script>

<main>
  <div class="grid-bg"></div>
  <div class="scanlines"></div>

  <div class="content">
    <div class="headline">
      <span class="static-text">Physics data for&nbsp;</span>
      <span
        class="cryptex-slot"
        style="width: {wordSlotWidth}px"
      >
        <span
          class="cryptex-word"
          class:exit={phase === 'exit'}
          class:enter={phase === 'enter'}
        >{words[current]}</span>
      </span>
    </div>
  </div>
</main>

<style>
  :global(*, *::before, *::after) { box-sizing: border-box; margin: 0; padding: 0; }
  :global(body) {
    background: #edf6f3;
    font-family: 'DM Mono', monospace;
  }

  main {
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    overflow: hidden;
    padding: 2rem 1.5rem;
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
    width: 100%;
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

  /* Fixed-width slot — always the width of the longest word */
  .cryptex-slot {
    display: inline-block;
    overflow: hidden;
    flex-shrink: 0;
    /* clip words that animate outside the slot */
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
    transition:
      transform 0.32s cubic-bezier(0.4, 0, 1, 0.6),
      opacity 0.25s ease;
  }

  .cryptex-word.enter {
    animation: enterWord 0.42s cubic-bezier(0.22, 1, 0.36, 1) forwards;
  }

  @keyframes enterWord {
    0%   { transform: translateY(-130%); opacity: 0; }
    60%  { transform: translateY(8%);    opacity: 1; }
    80%  { transform: translateY(-3%);   opacity: 1; }
    100% { transform: translateY(0);     opacity: 1; }
  }
</style>