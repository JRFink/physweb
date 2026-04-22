<script>
  let filter = 'All';

  const modules = [
    { title: 'General Physics I',         slug: 'gp1',        level: 'Beginner',     icon: '🎯', topics: ['Kinematics', 'Newton\'s Laws', 'Energy', 'Momentum', 'Rotation'] },
    { title: 'General Physics II',        slug: 'gp2',        level: 'Beginner',     icon: '🌊', topics: ['Waves', 'Thermodynamics', 'Fluids', 'Oscillations'] },
    { title: 'Electricity & Magnetism',   slug: 'em',         level: 'Intermediate', icon: '⚡', topics: ['Electric Fields', 'Circuits', 'Magnetic Forces', 'Maxwell\'s Equations'] },
    { title: 'Classical Mechanics',       slug: 'cm',         level: 'Intermediate', icon: '🌐', topics: ['Lagrangian', 'Hamiltonian', 'Constraints', 'Chaos Theory'] },
    { title: 'Special Relativity',        slug: 'sr',         level: 'Intermediate', icon: '🚀', topics: ['Lorentz Transforms', 'Space-time', 'Four-vectors', 'Mass-Energy'] },
    { title: 'Optics',                    slug: 'optics',     level: 'Intermediate', icon: '🔭', topics: ['Geometric Optics', 'Interference', 'Diffraction', 'Lasers'] },
    { title: 'Quantum Mechanics',         slug: 'qm',         level: 'Advanced',     icon: '⚛️', topics: ['Wave Functions', 'Schrödinger Eq.', 'Operators', 'Spin', 'Perturbation Theory'] },
    { title: 'Statistical Mechanics',     slug: 'stat',       level: 'Advanced',     icon: '🔢', topics: ['Entropy', 'Partition Functions', 'Phase Transitions', 'Ensembles'] },
    { title: 'Electrodynamics',           slug: 'edyn',       level: 'Advanced',     icon: '🌀', topics: ['Radiation', 'Potentials', 'Gauge Invariance', 'Retarded Fields'] },
    { title: 'Quantum Field Theory',      slug: 'qft',        level: 'Advanced',     icon: '🔮', topics: ['Feynman Diagrams', 'Path Integrals', 'Renormalization', 'QED'] },
    { title: 'General Relativity',        slug: 'gr',         level: 'Advanced',     icon: '🌌', topics: ['Tensors', 'Geodesics', 'Einstein Equations', 'Black Holes'] },
    { title: 'Nuclear Physics',           slug: 'nuclear',    level: 'Advanced',     icon: '☢️', topics: ['Nuclear Structure', 'Decay Modes', 'Fission', 'Fusion'] },
  ];

  const levels = ['All', 'Beginner', 'Intermediate', 'Advanced'];
  const levelColor = { Beginner: 'green', Intermediate: 'blue', Advanced: 'purple' };

  $: filtered = filter === 'All' ? modules : modules.filter(m => m.level === filter);
</script>

<div class="page">
  <div class="page-hero">
    <div class="container">
      <div class="section-label">Curriculum</div>
      <h1 class="section-title">Learning <span class="gradient-text">Modules</span></h1>
      <p class="section-sub">Work through physics from the ground up. Track your progress, test your understanding, and build real mastery.</p>
    </div>
  </div>

  <div class="container content">
    <div class="filter-bar">
      {#each levels as lvl}
        <button
          class="filter-btn"
          class:active={filter === lvl}
          on:click={() => filter = lvl}
        >{lvl}</button>
      {/each}
      <span class="module-count">{filtered.length} module{filtered.length !== 1 ? 's' : ''}</span>
    </div>

    <div class="modules-list">
      {#each filtered as mod}
        <a href="/learn/{mod.slug}" class="module-row">
          <div class="mod-icon">{mod.icon}</div>
          <div class="mod-info">
            <div class="mod-title-row">
              <h2>{mod.title}</h2>
              <span class="level-badge {levelColor[mod.level]}">{mod.level}</span>
            </div>
            <div class="topics">
              {#each mod.topics as topic}
                <span class="topic-chip">{topic}</span>
              {/each}
            </div>
          </div>
          <div class="mod-cta">
            <span class="mod-status">Coming Soon</span>
            <span class="mod-arrow">→</span>
          </div>
        </a>
      {/each}
    </div>

    <div class="coming-soon-note">
      <span>🔒</span>
      <p>Modules are currently in development. <a href="/auth/register">Sign up</a> to get notified when they launch.</p>
    </div>
  </div>
</div>

<style>
  .page-hero {
    padding: 4rem 0 3rem;
    border-bottom: 1px solid var(--border);
  }

  .content {
    padding: 2.5rem 1.5rem;
  }

  .filter-bar {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 1.5rem;
    flex-wrap: wrap;
  }

  .filter-btn {
    padding: 0.4rem 1rem;
    border-radius: 50px;
    border: 1px solid var(--border-bright);
    background: transparent;
    color: var(--text-dim);
    font-size: 0.875rem;
    font-weight: 500;
    transition: all 0.15s;
  }

  .filter-btn:hover,
  .filter-btn.active {
    background: var(--surface-2);
    color: var(--text);
    border-color: transparent;
  }

  .filter-btn.active {
    background: var(--grad);
    color: #fff;
  }

  .module-count {
    margin-left: auto;
    font-size: 0.8rem;
    color: var(--text-muted);
  }

  .modules-list {
    display: flex;
    flex-direction: column;
    gap: 1px;
    background: var(--border);
    border: 1px solid var(--border);
    border-radius: var(--radius-lg);
    overflow: hidden;
  }

  .module-row {
    display: flex;
    align-items: center;
    gap: 1.25rem;
    padding: 1.25rem 1.5rem;
    background: var(--surface);
    transition: background 0.15s;
  }

  .module-row:hover {
    background: var(--surface-2);
  }

  .mod-icon {
    font-size: 1.75rem;
    width: 52px;
    height: 52px;
    background: var(--surface-2);
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
  }

  .mod-info {
    flex: 1;
    min-width: 0;
  }

  .mod-title-row {
    display: flex;
    align-items: center;
    gap: 0.6rem;
    margin-bottom: 0.5rem;
    flex-wrap: wrap;
  }

  .mod-title-row h2 {
    font-size: 1rem;
    font-weight: 600;
  }

  .topics {
    display: flex;
    flex-wrap: wrap;
    gap: 0.4rem;
  }

  .topic-chip {
    font-size: 0.7rem;
    padding: 0.15rem 0.55rem;
    background: var(--surface-2);
    border: 1px solid var(--border);
    border-radius: 4px;
    color: var(--text-muted);
  }

  .level-badge {
    font-size: 0.65rem;
    font-weight: 600;
    letter-spacing: 0.05em;
    text-transform: uppercase;
    padding: 0.2rem 0.55rem;
    border-radius: 50px;
    flex-shrink: 0;
  }

  .level-badge.green  { background: var(--green-dim);  color: var(--green); }
  .level-badge.blue   { background: var(--blue-dim);   color: var(--blue); }
  .level-badge.purple { background: var(--purple-dim); color: var(--purple); }

  .mod-cta {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    gap: 0.25rem;
    flex-shrink: 0;
  }

  .mod-status {
    font-size: 0.72rem;
    color: var(--text-muted);
  }

  .mod-arrow {
    font-size: 1.1rem;
    color: var(--text-muted);
    transition: transform 0.15s, color 0.15s;
  }

  .module-row:hover .mod-arrow {
    transform: translateX(3px);
    color: var(--text);
  }

  .coming-soon-note {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    margin-top: 1.5rem;
    padding: 1rem 1.25rem;
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: var(--radius);
    font-size: 0.875rem;
    color: var(--text-dim);
  }

  .coming-soon-note a {
    color: var(--blue);
    text-decoration: underline;
  }

  @media (max-width: 600px) {
    .mod-cta { display: none; }
  }
</style>
