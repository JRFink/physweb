<script>
  const modules = [
    { title: 'General Physics I',       slug: 'gp1',    level: 'Beginner',     icon: '🎯', desc: 'Mechanics, kinematics, Newton\'s laws, energy, and momentum.' },
    { title: 'General Physics II',      slug: 'gp2',    level: 'Beginner',     icon: '🌊', desc: 'Waves, thermodynamics, fluids, and oscillations.' },
    { title: 'Electricity & Magnetism', slug: 'em',     level: 'Intermediate', icon: '⚡', desc: 'Electric fields, circuits, magnetic forces, and Maxwell\'s equations.' },
    { title: 'Quantum Mechanics',       slug: 'qm',     level: 'Advanced',     icon: '⚛️', desc: 'Wave functions, operators, Schrödinger equation, and spin.' },
    { title: 'Classical Mechanics',     slug: 'cm',     level: 'Intermediate', icon: '🌐', desc: 'Lagrangian and Hamiltonian formulations, constraints, and chaos.' },
    { title: 'Special Relativity',      slug: 'sr',     level: 'Intermediate', icon: '🚀', desc: 'Space-time, Lorentz transformations, four-vectors, and paradoxes.' },
    { title: 'Statistical Mechanics',   slug: 'stat',   level: 'Advanced',     icon: '🔢', desc: 'Entropy, partition functions, phase transitions, and ensembles.' },
    { title: 'Optics',                  slug: 'optics', level: 'Intermediate', icon: '🔭', desc: 'Geometrical optics, interference, diffraction, and lasers.' },
  ];

  const research = [
    { title: 'Atomic, Molecular & Optical', icon: '💡', color: 'green',  desc: 'Precision measurements, ultracold atoms, and light-matter interaction.' },
    { title: 'Particle Physics',            icon: '🔬', color: 'blue',   desc: 'The Standard Model, collider experiments, and beyond-SM physics.' },
    { title: 'Condensed Matter',            icon: '🧲', color: 'purple', desc: 'Superconductivity, topological phases, and emergent quantum phenomena.' },
    { title: 'Astrophysics & Cosmology',    icon: '🌌', color: 'blue',   desc: 'Dark matter, gravitational waves, black holes, and the early universe.' },
  ];

  const levelColor = { Beginner: 'green', Intermediate: 'blue', Advanced: 'purple' };
</script>

<!-- Hero -->
<section class="hero">
  <div class="blob blob-1"></div>
  <div class="blob blob-2"></div>
  <div class="blob blob-3"></div>
  <div class="grid-overlay"></div>

  <div class="hero-inner container">
    <div class="badge">Physics Education & Research</div>
    <h1>Master <span class="gradient-text">Physics</span><br />at Every Level</h1>
    <p class="hero-sub">
      Structured learning modules, frontier research insights, and on-demand expert tutoring —
      all in one platform built for serious learners.
    </p>
    <div class="hero-ctas">
      <a href="/auth/register" class="btn-primary">Get Started Free</a>
      <a href="/learn" class="btn-ghost">Explore Modules →</a>
    </div>

    <div class="hero-stats">
      <div class="stat">
        <span class="stat-n">20+</span>
        <span class="stat-l">Learning Modules</span>
      </div>
      <div class="stat-divider"></div>
      <div class="stat">
        <span class="stat-n">8</span>
        <span class="stat-l">Research Areas</span>
      </div>
      <div class="stat-divider"></div>
      <div class="stat">
        <span class="stat-n">Expert</span>
        <span class="stat-l">On-Demand Tutors</span>
      </div>
    </div>
  </div>
</section>

<!-- Features -->
<section class="features">
  <div class="container">
    <div class="section-label">What We Offer</div>
    <h2 class="section-title">Everything You Need to <span class="gradient-text">Excel in Physics</span></h2>

    <div class="feature-grid">
      <div class="feature-card green">
        <div class="feature-icon">📚</div>
        <h3>Structured Learning</h3>
        <p>Work through expertly curated modules from intro mechanics to advanced quantum field theory, all with progress tracking and quizzes.</p>
        <a href="/learn" class="feature-link">Browse modules →</a>
      </div>
      <div class="feature-card blue">
        <div class="feature-icon">🔭</div>
        <h3>Research Insights</h3>
        <p>Explore active research areas across all major subfields of physics — from particle accelerators to gravitational wave observatories.</p>
        <a href="/research" class="feature-link">Explore research →</a>
      </div>
      <div class="feature-card purple">
        <div class="feature-icon">👨‍🏫</div>
        <h3>Expert Tutoring</h3>
        <p>Book on-demand sessions with verified physics experts. Get personalized help with problem sets, concepts, and exam prep.</p>
        <a href="/tutoring" class="feature-link">Find a tutor →</a>
      </div>
    </div>
  </div>
</section>

<!-- Modules Preview -->
<section class="modules-section">
  <div class="container">
    <div class="section-header">
      <div>
        <div class="section-label">Curriculum</div>
        <h2 class="section-title">Learning <span class="gradient-text">Modules</span></h2>
        <p class="section-sub">From first-semester mechanics to graduate-level quantum theory.</p>
      </div>
      <a href="/learn" class="btn-ghost">View all →</a>
    </div>

    <div class="modules-grid">
      {#each modules as mod}
        <a href="/learn/{mod.slug}" class="module-card">
          <div class="module-icon">{mod.icon}</div>
          <div class="module-info">
            <div class="module-top">
              <h3>{mod.title}</h3>
              <span class="level-badge {levelColor[mod.level]}">{mod.level}</span>
            </div>
            <p>{mod.desc}</p>
          </div>
          <span class="module-arrow">→</span>
        </a>
      {/each}
    </div>
  </div>
</section>

<!-- Research Preview -->
<section class="research-section">
  <div class="container">
    <div class="section-label">Current Frontiers</div>
    <h2 class="section-title">Active Research <span class="gradient-text">Areas</span></h2>
    <p class="section-sub">Understand what physicists are working on right now.</p>

    <div class="research-grid">
      {#each research as area}
        <a href="/research" class="research-card {area.color}">
          <span class="research-icon">{area.icon}</span>
          <h3>{area.title}</h3>
          <p>{area.desc}</p>
          <span class="research-link">Learn more →</span>
        </a>
      {/each}
    </div>
  </div>
</section>

<!-- CTA -->
<section class="cta-section">
  <div class="blob cta-blob-1"></div>
  <div class="blob cta-blob-2"></div>
  <div class="container cta-inner">
    <h2>Ready to <span class="gradient-text">Level Up</span> Your Physics?</h2>
    <p>Join thousands of students, researchers, and engineers on physweb.</p>
    <div class="cta-btns">
      <a href="/auth/register" class="btn-primary">Create Free Account</a>
      <a href="/tutoring" class="btn-ghost">Book a Tutor</a>
    </div>
  </div>
</section>

<style>
  /* Hero */
  .hero {
    position: relative;
    overflow: hidden;
    min-height: calc(100vh - var(--nav-h));
    display: flex;
    align-items: center;
    padding: 5rem 0;
  }

  .blob {
    position: absolute;
    border-radius: 50%;
    filter: blur(90px);
    pointer-events: none;
  }

  .blob-1 {
    width: 700px; height: 700px;
    background: radial-gradient(circle, rgba(6,214,160,0.18), transparent 70%);
    top: -200px; left: -150px;
    animation: drift 18s ease-in-out infinite;
  }

  .blob-2 {
    width: 600px; height: 600px;
    background: radial-gradient(circle, rgba(74,158,255,0.18), transparent 70%);
    top: 50px; right: -200px;
    animation: drift 22s ease-in-out infinite reverse;
  }

  .blob-3 {
    width: 500px; height: 500px;
    background: radial-gradient(circle, rgba(168,85,247,0.14), transparent 70%);
    bottom: -100px; left: 40%;
    animation: drift 26s ease-in-out infinite;
    animation-delay: -8s;
  }

  @keyframes drift {
    0%, 100% { transform: translate(0, 0); }
    33%       { transform: translate(30px, -40px); }
    66%       { transform: translate(-20px, 30px); }
  }

  .grid-overlay {
    position: absolute;
    inset: 0;
    background-image:
      linear-gradient(rgba(255,255,255,0.025) 1px, transparent 1px),
      linear-gradient(90deg, rgba(255,255,255,0.025) 1px, transparent 1px);
    background-size: 48px 48px;
    mask-image: radial-gradient(ellipse 80% 80% at 50% 50%, black 40%, transparent 100%);
  }

  .hero-inner {
    position: relative;
    z-index: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    gap: 1.5rem;
  }

  .badge {
    display: inline-block;
    padding: 0.35rem 1rem;
    border-radius: 50px;
    border: 1px solid var(--border-bright);
    background: rgba(255,255,255,0.04);
    font-size: 0.78rem;
    font-weight: 500;
    letter-spacing: 0.06em;
    text-transform: uppercase;
    color: var(--text-dim);
  }

  .hero h1 {
    font-size: clamp(2.4rem, 6vw, 4.5rem);
    font-weight: 800;
    line-height: 1.1;
    letter-spacing: -0.03em;
  }

  .hero-sub {
    font-size: clamp(1rem, 2vw, 1.15rem);
    color: var(--text-dim);
    max-width: 540px;
    line-height: 1.7;
  }

  .hero-ctas {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
    justify-content: center;
    margin-top: 0.5rem;
  }

  .hero-stats {
    display: flex;
    align-items: center;
    gap: 2rem;
    margin-top: 2rem;
    padding: 1.25rem 2rem;
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: var(--radius-lg);
    flex-wrap: wrap;
    justify-content: center;
  }

  .stat { text-align: center; }
  .stat-n { display: block; font-size: 1.5rem; font-weight: 700; }
  .stat-l { display: block; font-size: 0.78rem; color: var(--text-muted); margin-top: 0.15rem; }

  .stat-divider {
    width: 1px;
    height: 36px;
    background: var(--border-bright);
  }

  /* Features */
  .features {
    padding: 5rem 0;
  }

  .feature-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 1.25rem;
    margin-top: 2.5rem;
  }

  .feature-card {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: var(--radius-lg);
    padding: 2rem;
    transition: border-color 0.2s, transform 0.2s;
    position: relative;
    overflow: hidden;
  }

  .feature-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 2px;
    border-radius: 2px 2px 0 0;
  }

  .feature-card.green::before { background: var(--green); }
  .feature-card.blue::before  { background: var(--blue); }
  .feature-card.purple::before { background: var(--purple); }

  .feature-card:hover {
    border-color: var(--border-bright);
    transform: translateY(-3px);
  }

  .feature-icon {
    font-size: 2rem;
    margin-bottom: 1rem;
  }

  .feature-card h3 {
    font-size: 1.15rem;
    font-weight: 600;
    margin-bottom: 0.6rem;
  }

  .feature-card p {
    font-size: 0.9rem;
    color: var(--text-dim);
    line-height: 1.65;
    margin-bottom: 1.25rem;
  }

  .feature-link {
    font-size: 0.875rem;
    font-weight: 500;
    transition: color 0.15s;
  }

  .feature-card.green .feature-link { color: var(--green); }
  .feature-card.blue  .feature-link { color: var(--blue); }
  .feature-card.purple .feature-link { color: var(--purple); }

  /* Modules */
  .modules-section {
    padding: 5rem 0;
  }

  .section-header {
    display: flex;
    align-items: flex-end;
    justify-content: space-between;
    gap: 1rem;
    margin-bottom: 2rem;
  }

  .modules-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 1px;
    background: var(--border);
    border: 1px solid var(--border);
    border-radius: var(--radius-lg);
    overflow: hidden;
  }

  .module-card {
    display: flex;
    align-items: center;
    gap: 1rem;
    padding: 1.25rem 1.5rem;
    background: var(--surface);
    transition: background 0.15s;
  }

  .module-card:hover {
    background: var(--surface-2);
  }

  .module-icon {
    font-size: 1.5rem;
    flex-shrink: 0;
    width: 44px;
    height: 44px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: var(--surface-2);
    border-radius: 10px;
  }

  .module-info {
    flex: 1;
    min-width: 0;
  }

  .module-top {
    display: flex;
    align-items: center;
    gap: 0.6rem;
    margin-bottom: 0.25rem;
    flex-wrap: wrap;
  }

  .module-top h3 {
    font-size: 0.95rem;
    font-weight: 600;
  }

  .module-info p {
    font-size: 0.8rem;
    color: var(--text-muted);
    line-height: 1.5;
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

  .module-arrow {
    font-size: 1rem;
    color: var(--text-muted);
    flex-shrink: 0;
    transition: transform 0.15s, color 0.15s;
  }

  .module-card:hover .module-arrow {
    transform: translateX(3px);
    color: var(--text);
  }

  /* Research */
  .research-section {
    padding: 5rem 0;
    background: var(--surface);
    border-top: 1px solid var(--border);
    border-bottom: 1px solid var(--border);
  }

  .research-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 1.25rem;
    margin-top: 2.5rem;
  }

  .research-card {
    padding: 1.75rem;
    background: var(--bg);
    border: 1px solid var(--border);
    border-radius: var(--radius-lg);
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
    transition: border-color 0.2s, transform 0.2s;
  }

  .research-card:hover {
    border-color: var(--border-bright);
    transform: translateY(-3px);
  }

  .research-icon { font-size: 1.75rem; }

  .research-card h3 {
    font-size: 0.95rem;
    font-weight: 600;
    line-height: 1.3;
  }

  .research-card p {
    font-size: 0.82rem;
    color: var(--text-muted);
    line-height: 1.6;
    flex: 1;
  }

  .research-link {
    font-size: 0.82rem;
    font-weight: 500;
  }

  .research-card.green .research-link { color: var(--green); }
  .research-card.blue  .research-link { color: var(--blue); }
  .research-card.purple .research-link { color: var(--purple); }

  /* CTA */
  .cta-section {
    position: relative;
    overflow: hidden;
    padding: 6rem 0;
    text-align: center;
  }

  .cta-blob-1 {
    width: 500px; height: 500px;
    background: radial-gradient(circle, rgba(6,214,160,0.12), transparent 70%);
    top: -100px; left: -100px;
  }

  .cta-blob-2 {
    width: 500px; height: 500px;
    background: radial-gradient(circle, rgba(168,85,247,0.12), transparent 70%);
    bottom: -100px; right: -100px;
  }

  .cta-inner {
    position: relative;
    z-index: 1;
  }

  .cta-section h2 {
    font-size: clamp(1.8rem, 4vw, 3rem);
    font-weight: 700;
    margin-bottom: 1rem;
  }

  .cta-section p {
    color: var(--text-dim);
    font-size: 1.05rem;
    margin-bottom: 2rem;
  }

  .cta-btns {
    display: flex;
    gap: 1rem;
    justify-content: center;
    flex-wrap: wrap;
  }

  @media (max-width: 900px) {
    .feature-grid { grid-template-columns: 1fr; }
    .research-grid { grid-template-columns: repeat(2, 1fr); }
    .modules-grid  { grid-template-columns: 1fr; }
    .stat-divider  { display: none; }
    .section-header { flex-direction: column; align-items: flex-start; }
  }

  @media (max-width: 600px) {
    .research-grid { grid-template-columns: 1fr; }
    .hero-stats { gap: 1rem; }
  }
</style>
