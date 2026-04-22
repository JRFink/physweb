<script>
  const areas = [
    {
      title: 'Atomic, Molecular & Optical Physics',
      short: 'AMO',
      icon: '💡',
      color: 'green',
      desc: 'AMO physics probes the quantum nature of matter and light at the atomic scale. Key frontiers include ultracold atomic gases, precision measurement, quantum simulation, and the interaction of laser fields with matter.',
      topics: ['Ultracold Atoms', 'Bose-Einstein Condensates', 'Quantum Optics', 'Precision Spectroscopy', 'Attosecond Science', 'Optical Lattices'],
      labs: ['JILA', 'MIT-Harvard CUA', 'Caltech KNI'],
    },
    {
      title: 'Particle Physics & High Energy',
      short: 'HEP',
      icon: '🔬',
      color: 'blue',
      desc: 'High-energy physics investigates the fundamental constituents of matter and the forces between them. Experiments at the LHC and beyond probe the Standard Model, search for dark matter, and hunt for new physics.',
      topics: ['Standard Model', 'Higgs Boson', 'Supersymmetry', 'Dark Matter', 'Neutrino Physics', 'Collider Experiments'],
      labs: ['CERN', 'Fermilab', 'SLAC', 'DESY'],
    },
    {
      title: 'Condensed Matter Physics',
      short: 'CMP',
      icon: '🧲',
      color: 'purple',
      desc: 'Condensed matter studies the properties of matter in its condensed phases. It is the largest subfield of physics and drives most technological innovation, from semiconductors to superconductors to topological materials.',
      topics: ['Superconductivity', 'Topological Insulators', 'Quantum Hall Effect', 'Strongly Correlated Systems', 'Spintronics', 'Graphene'],
      labs: ['Bell Labs', 'IBM Research', 'MIT Research Laboratory'],
    },
    {
      title: 'Astrophysics & Cosmology',
      short: 'Astro',
      icon: '🌌',
      color: 'blue',
      desc: 'Astrophysics and cosmology span the largest scales in nature. Researchers study the formation of galaxies, the lifecycle of stars, the nature of dark energy, gravitational waves, and the origin of the universe.',
      topics: ['Dark Energy', 'Gravitational Waves', 'Black Holes', 'Neutron Stars', 'Cosmic Microwave Background', 'Large-Scale Structure'],
      labs: ['LIGO', 'Hubble / JWST', 'Planck Collaboration'],
    },
    {
      title: 'Quantum Information & Computing',
      short: 'QIS',
      icon: '💻',
      color: 'green',
      desc: 'Quantum information science harnesses quantum mechanics to process information in fundamentally new ways. Research covers quantum computing, quantum cryptography, error correction, and quantum communication.',
      topics: ['Quantum Circuits', 'Error Correction', 'Quantum Entanglement', 'Qubit Platforms', 'Quantum Cryptography', 'Quantum Advantage'],
      labs: ['Google Quantum AI', 'IBM Quantum', 'IQM', 'QuTech'],
    },
    {
      title: 'Nuclear Physics',
      short: 'NP',
      icon: '☢️',
      color: 'purple',
      desc: 'Nuclear physics studies the structure and behavior of atomic nuclei, from stable isotopes to exotic nuclear matter. Applications range from medical imaging to nuclear energy and national security.',
      topics: ['Nuclear Structure', 'Radioactive Decay', 'Nuclear Reactions', 'Neutron Stars', 'Quark-Gluon Plasma', 'Nuclear Astrophysics'],
      labs: ['TRIUMF', 'GSI/FAIR', 'Jefferson Lab', 'RIKEN'],
    },
    {
      title: 'Plasma Physics',
      short: 'Plasma',
      icon: '🔥',
      color: 'blue',
      desc: 'Plasma physics studies the fourth state of matter — ionized gas — which makes up 99% of the visible universe. Major goals include achieving controlled nuclear fusion as a clean energy source.',
      topics: ['Magnetic Confinement', 'Inertial Confinement', 'MHD', 'Fusion Reactors', 'Space Plasma', 'Laser-Plasma Interaction'],
      labs: ['ITER', 'NIF', 'Princeton PPPL', 'Commonwealth Fusion'],
    },
    {
      title: 'Biophysics',
      short: 'Bio',
      icon: '🧬',
      color: 'green',
      desc: 'Biophysics applies physics principles and methods to biological systems, from single molecules to entire organisms. It bridges physics and biology to understand life at a fundamental level.',
      topics: ['Protein Folding', 'Single-Molecule Studies', 'Membrane Biophysics', 'Neural Networks', 'Optical Tweezers', 'Cryo-EM'],
      labs: ['NIH', 'HHMI', 'Salk Institute'],
    },
  ];
</script>

<div class="page">
  <div class="page-hero">
    <div class="container">
      <div class="section-label">Current Frontiers</div>
      <h1 class="section-title">Physics Research <span class="gradient-text">Areas</span></h1>
      <p class="section-sub">Explore what physicists are working on right now. From quantum computers to gravitational waves — physics is everywhere.</p>
    </div>
  </div>

  <div class="container content">
    <div class="areas-grid">
      {#each areas as area}
        <div class="area-card {area.color}">
          <div class="area-header">
            <span class="area-icon">{area.icon}</span>
            <div>
              <div class="area-short">{area.short}</div>
              <h2>{area.title}</h2>
            </div>
          </div>
          <p class="area-desc">{area.desc}</p>
          <div class="topics">
            {#each area.topics as topic}
              <span class="topic-chip">{topic}</span>
            {/each}
          </div>
          <div class="area-labs">
            <span class="labs-label">Key labs & collaborations</span>
            <div class="labs">
              {#each area.labs as lab}
                <span class="lab-chip">{lab}</span>
              {/each}
            </div>
          </div>
        </div>
      {/each}
    </div>
  </div>
</div>

<style>
  .page-hero {
    padding: 4rem 0 3rem;
    border-bottom: 1px solid var(--border);
  }

  .content {
    padding: 3rem 1.5rem;
  }

  .areas-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 1.25rem;
  }

  .area-card {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: var(--radius-lg);
    padding: 2rem;
    display: flex;
    flex-direction: column;
    gap: 1rem;
    position: relative;
    overflow: hidden;
    transition: border-color 0.2s;
  }

  .area-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 2px;
  }

  .area-card.green::before  { background: var(--green); }
  .area-card.blue::before   { background: var(--blue); }
  .area-card.purple::before { background: var(--purple); }

  .area-card:hover {
    border-color: var(--border-bright);
  }

  .area-header {
    display: flex;
    align-items: center;
    gap: 1rem;
  }

  .area-icon {
    font-size: 2rem;
    flex-shrink: 0;
    width: 56px;
    height: 56px;
    background: var(--surface-2);
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .area-short {
    font-size: 0.7rem;
    font-weight: 600;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    color: var(--text-muted);
    margin-bottom: 0.2rem;
  }

  .area-header h2 {
    font-size: 1rem;
    font-weight: 600;
    line-height: 1.3;
  }

  .area-desc {
    font-size: 0.875rem;
    color: var(--text-dim);
    line-height: 1.65;
  }

  .topics {
    display: flex;
    flex-wrap: wrap;
    gap: 0.4rem;
  }

  .topic-chip {
    font-size: 0.72rem;
    padding: 0.25rem 0.6rem;
    background: var(--surface-2);
    border: 1px solid var(--border);
    border-radius: 6px;
    color: var(--text-dim);
  }

  .area-labs {
    margin-top: 0.25rem;
  }

  .labs-label {
    font-size: 0.7rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    color: var(--text-muted);
    display: block;
    margin-bottom: 0.5rem;
  }

  .labs {
    display: flex;
    flex-wrap: wrap;
    gap: 0.4rem;
  }

  .lab-chip {
    font-size: 0.72rem;
    padding: 0.2rem 0.55rem;
    border-radius: 50px;
    font-weight: 500;
  }

  .area-card.green .lab-chip   { background: var(--green-dim);  color: var(--green); }
  .area-card.blue .lab-chip    { background: var(--blue-dim);   color: var(--blue); }
  .area-card.purple .lab-chip  { background: var(--purple-dim); color: var(--purple); }

  @media (max-width: 768px) {
    .areas-grid { grid-template-columns: 1fr; }
  }
</style>
