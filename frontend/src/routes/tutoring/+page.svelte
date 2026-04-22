<script>
  const steps = [
    { n: '01', title: 'Choose Your Topic',   desc: 'Browse by subject area or describe exactly what you need help with — from problem sets to conceptual questions to exam prep.' },
    { n: '02', title: 'Match with an Expert', desc: 'We match you with a verified physics expert based on your topic, level, and schedule. All tutors hold advanced degrees in physics.' },
    { n: '03', title: 'Learn & Level Up',     desc: 'Connect via live video or async messaging. Sessions are recorded so you can review explanations anytime.' },
  ];

  const subjects = [
    'General Physics', 'Electricity & Magnetism', 'Quantum Mechanics',
    'Classical Mechanics', 'Statistical Mechanics', 'Special Relativity',
    'Optics', 'Nuclear Physics', 'Astrophysics', 'Condensed Matter',
    'Particle Physics', 'Problem Set Help', 'Exam Prep', 'Research Guidance',
  ];

  const plans = [
    {
      name: 'Single Session',
      price: '$65',
      per: 'per hour',
      color: 'green',
      features: [
        'One-on-one live session',
        'Screen sharing & whiteboard',
        'Session recording',
        'Follow-up Q&A (24h)',
      ],
      cta: 'Book a Session',
    },
    {
      name: 'Monthly Plan',
      price: '$199',
      per: 'per month',
      color: 'blue',
      featured: true,
      features: [
        '4 hours of tutoring / month',
        'Priority matching',
        'Session recordings',
        'Unlimited async Q&A',
        'Progress tracking',
      ],
      cta: 'Start Monthly Plan',
    },
    {
      name: 'Intensive',
      price: '$349',
      per: 'per month',
      color: 'purple',
      features: [
        '8 hours of tutoring / month',
        'Dedicated tutor',
        'Session recordings',
        'Unlimited async Q&A',
        'Progress tracking',
        'Custom study plan',
      ],
      cta: 'Start Intensive',
    },
  ];
</script>

<div class="page">
  <!-- Hero -->
  <div class="page-hero">
    <div class="blob hero-blob-1"></div>
    <div class="blob hero-blob-2"></div>
    <div class="container hero-inner">
      <div class="section-label">On-Demand Tutoring</div>
      <h1 class="section-title">Expert Physics Help,<br /><span class="gradient-text">When You Need It</span></h1>
      <p class="section-sub">Connect with verified physics experts for live one-on-one tutoring. Every tutor holds an advanced degree in physics and is vetted for teaching excellence.</p>
      <div class="hero-ctas">
        <a href="/auth/register" class="btn-primary">Get Matched Now</a>
        <a href="#pricing" class="btn-ghost">See Pricing</a>
      </div>
    </div>
  </div>

  <!-- How it Works -->
  <section class="how-section">
    <div class="container">
      <div class="section-label">Process</div>
      <h2 class="section-title">How It <span class="gradient-text">Works</span></h2>
      <div class="steps">
        {#each steps as step}
          <div class="step">
            <div class="step-n">{step.n}</div>
            <h3>{step.title}</h3>
            <p>{step.desc}</p>
          </div>
        {/each}
      </div>
    </div>
  </section>

  <!-- Subjects -->
  <section class="subjects-section">
    <div class="container">
      <div class="section-label">Coverage</div>
      <h2 class="section-title">Topics We <span class="gradient-text">Cover</span></h2>
      <div class="subjects-cloud">
        {#each subjects as subject}
          <span class="subject-chip">{subject}</span>
        {/each}
      </div>
    </div>
  </section>

  <!-- Pricing -->
  <section class="pricing-section" id="pricing">
    <div class="container">
      <div class="section-label">Pricing</div>
      <h2 class="section-title">Simple, Transparent <span class="gradient-text">Pricing</span></h2>
      <p class="section-sub">No subscriptions required to start. Pay per session or save with a monthly plan.</p>

      <div class="plans-grid">
        {#each plans as plan}
          <div class="plan-card {plan.color}" class:featured={plan.featured}>
            {#if plan.featured}
              <div class="plan-badge">Most Popular</div>
            {/if}
            <div class="plan-name">{plan.name}</div>
            <div class="plan-price">
              <span class="price-num">{plan.price}</span>
              <span class="price-per">{plan.per}</span>
            </div>
            <ul class="plan-features">
              {#each plan.features as feat}
                <li><span class="check">✓</span>{feat}</li>
              {/each}
            </ul>
            <a href="/auth/register" class="plan-cta {plan.color}">{plan.cta}</a>
          </div>
        {/each}
      </div>
    </div>
  </section>

  <!-- Trust -->
  <section class="trust-section">
    <div class="container">
      <div class="trust-grid">
        <div class="trust-item">
          <span class="trust-icon">🎓</span>
          <h3>PhD-Level Experts</h3>
          <p>All tutors hold MS or PhD degrees in physics and are vetted through a rigorous selection process.</p>
        </div>
        <div class="trust-item">
          <span class="trust-icon">⚡</span>
          <h3>On-Demand Availability</h3>
          <p>Find available tutors any time of day. Most sessions can be booked within 2 hours of request.</p>
        </div>
        <div class="trust-item">
          <span class="trust-icon">🔁</span>
          <h3>Satisfaction Guarantee</h3>
          <p>Not happy with your session? We'll refund your credits or match you with a different tutor, no questions asked.</p>
        </div>
      </div>
    </div>
  </section>
</div>

<style>
  .page-hero {
    position: relative;
    overflow: hidden;
    padding: 5rem 0;
    border-bottom: 1px solid var(--border);
  }

  .hero-blob-1 {
    width: 600px; height: 600px;
    background: radial-gradient(circle, rgba(6,214,160,0.14), transparent 70%);
    top: -150px; left: -150px;
    position: absolute;
    border-radius: 50%;
    filter: blur(80px);
  }

  .hero-blob-2 {
    width: 500px; height: 500px;
    background: radial-gradient(circle, rgba(168,85,247,0.12), transparent 70%);
    bottom: -100px; right: -100px;
    position: absolute;
    border-radius: 50%;
    filter: blur(80px);
  }

  .hero-inner {
    position: relative;
    z-index: 1;
  }

  .hero-ctas {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
    margin-top: 1rem;
  }

  /* How it works */
  .how-section {
    padding: 5rem 0;
  }

  .steps {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 2rem;
    margin-top: 2.5rem;
  }

  .step {
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
  }

  .step-n {
    font-size: 2.5rem;
    font-weight: 800;
    font-family: 'DM Mono', monospace;
    background: var(--grad);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    line-height: 1;
  }

  .step h3 {
    font-size: 1.05rem;
    font-weight: 600;
  }

  .step p {
    font-size: 0.875rem;
    color: var(--text-dim);
    line-height: 1.65;
  }

  /* Subjects */
  .subjects-section {
    padding: 4rem 0;
    background: var(--surface);
    border-top: 1px solid var(--border);
    border-bottom: 1px solid var(--border);
  }

  .subjects-cloud {
    display: flex;
    flex-wrap: wrap;
    gap: 0.6rem;
    margin-top: 2rem;
  }

  .subject-chip {
    padding: 0.45rem 1rem;
    background: var(--surface-2);
    border: 1px solid var(--border-bright);
    border-radius: 50px;
    font-size: 0.875rem;
    color: var(--text-dim);
    transition: color 0.15s, border-color 0.15s;
    cursor: default;
  }

  .subject-chip:hover {
    color: var(--text);
    border-color: rgba(255,255,255,0.3);
  }

  /* Pricing */
  .pricing-section {
    padding: 5rem 0;
  }

  .plans-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 1.25rem;
    margin-top: 2.5rem;
    align-items: start;
  }

  .plan-card {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: var(--radius-lg);
    padding: 2rem;
    position: relative;
    display: flex;
    flex-direction: column;
    gap: 1.25rem;
  }

  .plan-card.featured {
    border-color: var(--blue);
    box-shadow: 0 0 40px rgba(74,158,255,0.12);
  }

  .plan-badge {
    position: absolute;
    top: -12px;
    left: 50%;
    transform: translateX(-50%);
    background: var(--blue);
    color: #fff;
    font-size: 0.7rem;
    font-weight: 700;
    letter-spacing: 0.06em;
    text-transform: uppercase;
    padding: 0.25rem 0.85rem;
    border-radius: 50px;
    white-space: nowrap;
  }

  .plan-name {
    font-size: 0.85rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    color: var(--text-dim);
  }

  .plan-price {
    display: flex;
    align-items: baseline;
    gap: 0.4rem;
  }

  .price-num {
    font-size: 2.5rem;
    font-weight: 800;
    letter-spacing: -0.02em;
  }

  .price-per {
    font-size: 0.85rem;
    color: var(--text-muted);
  }

  .plan-features {
    list-style: none;
    display: flex;
    flex-direction: column;
    gap: 0.6rem;
    flex: 1;
  }

  .plan-features li {
    display: flex;
    align-items: center;
    gap: 0.6rem;
    font-size: 0.875rem;
    color: var(--text-dim);
  }

  .check {
    font-size: 0.75rem;
    font-weight: 700;
    flex-shrink: 0;
  }

  .plan-card.green .check  { color: var(--green); }
  .plan-card.blue .check   { color: var(--blue); }
  .plan-card.purple .check { color: var(--purple); }

  .plan-cta {
    display: block;
    text-align: center;
    padding: 0.7rem 1.5rem;
    border-radius: 50px;
    font-weight: 600;
    font-size: 0.9rem;
    transition: opacity 0.2s, transform 0.2s;
    border: none;
  }

  .plan-cta:hover {
    opacity: 0.85;
    transform: translateY(-1px);
  }

  .plan-cta.green  { background: var(--green-dim);  color: var(--green); }
  .plan-cta.purple { background: var(--purple-dim); color: var(--purple); }
  .plan-cta.blue   { background: var(--grad);       color: #fff; box-shadow: 0 0 20px rgba(74,158,255,0.25); }

  /* Trust */
  .trust-section {
    padding: 4rem 0 5rem;
    border-top: 1px solid var(--border);
  }

  .trust-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 2rem;
  }

  .trust-item {
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
  }

  .trust-icon {
    font-size: 2rem;
  }

  .trust-item h3 {
    font-size: 1rem;
    font-weight: 600;
  }

  .trust-item p {
    font-size: 0.875rem;
    color: var(--text-dim);
    line-height: 1.65;
  }

  @media (max-width: 900px) {
    .steps      { grid-template-columns: 1fr; }
    .plans-grid { grid-template-columns: 1fr; }
    .trust-grid { grid-template-columns: 1fr; }
  }
</style>
