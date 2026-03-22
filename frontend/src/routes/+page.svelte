<script>
  import { onMount } from 'svelte';

  const words = ['students', 'researchers', 'ai models', 'engineers'];
  let current = 0;
  let next = 1;
  let phase = 'idle'; // idle | exit | enter

  function tick() {
    next = (current + 1) % words.length;
    phase = 'exit';

    setTimeout(() => {
      current = next;
      phase = 'enter';
      setTimeout(() => {
        phase = 'idle';
      }, 450);
    }, 350);
  }

  onMount(() => {
    const interval = setInterval(tick, 2600);
    return () => clearInterval(interval);
  });
</script>

<main>
  <div class="grid-bg"></div>
  <div class="scanlines"></div>

  <div class="content">
    <div class="headline">
      <span class="static-text">Physics data for&nbsp;</span>
      <span
        class="cryptex-word"
        class:exit={phase === 'exit'}
        class:enter={phase === 'enter'}
      >{words[current]}</span>
    </div>
    <div class="ticker-line"></div>
  </div>
</main>

<style>
  :global(*, *::before, *::after) { box-sizing: border-box; margin: 0; padding: 0; }
  :global(body) {
    background: #ecf6f3;
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

  .cryptex-word {
    font-size: clamp(1rem, 5vw, 2.2rem);
    font-weight: 300;
    color: #1a7a4a;
    white-space: nowrap;
    letter-spacing: -0.01em;
    display: inline-block;
    /* default: visible, in place */
    transform: translateY(0);
    opacity: 1;
    transition: none;
  }

  /* Exit: word drops down and fades out */
  .cryptex-word.exit {
    transform: translateY(120%);
    opacity: 0;
    transition:
      transform 0.32s cubic-bezier(0.4, 0, 1, 0.6),
      opacity 0.25s ease;
  }

  /* Enter: word comes from above, overshoots, snaps into baseline */
  .cryptex-word.enter {
    animation: enterWord 0.42s cubic-bezier(0.22, 1, 0.36, 1) forwards;
  }

  @keyframes enterWord {
    0%   { transform: translateY(-130%); opacity: 0; }
    60%  { transform: translateY(8%);    opacity: 1; }
    80%  { transform: translateY(-3%);   opacity: 1; }
    100% { transform: translateY(0);     opacity: 1; }
  }

  .ticker-line {
    width: 48px;
    height: 1px;
    background: #1a7a4a;
    opacity: 0.4;
  }
</style>