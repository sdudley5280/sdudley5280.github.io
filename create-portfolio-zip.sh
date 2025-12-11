#!/usr/bin/env bash
# Creates a portfolio scaffold and zips it as ../portfolio-site.zip
set -euo pipefail

ROOT_DIR="portfolio-site"
ZIP_OUT="../portfolio-site.zip"

rm -rf "$ROOT_DIR" "$ZIP_OUT"
mkdir -p "$ROOT_DIR"
cd "$ROOT_DIR"

# package.json
cat > package.json <<'EOF'
{
  "name": "portfolio-site",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview --port 5173",
    "start": "vite",
    "format": "prettier --write \"src/**/*.{ts,tsx,css,md}\""
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  },
  "devDependencies": {
    "@types/react": "^18.0.28",
    "@types/react-dom": "^18.0.11",
    "@vitejs/plugin-react": "^4.0.0",
    "typescript": "^5.2.0",
    "vite": "^5.0.0",
    "prettier": "^3.0.0"
  }
}
EOF

# tsconfig.json
cat > tsconfig.json <<'EOF'
{
  "compilerOptions": {
    "target": "ES2021",
    "useDefineForClassFields": true,
    "lib": ["DOM", "ES2021"],
    "allowJs": false,
    "skipLibCheck": true,
    "esModuleInterop": false,
    "allowSyntheticDefaultImports": true,
    "module": "ESNext",
    "moduleResolution": "Bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "baseUrl": ".",
    "paths": {
      "~/*": ["src/*"]
    }
  },
  "include": ["src"],
  "exclude": ["node_modules", "dist"]
}
EOF

# vite.config.ts
cat > vite.config.ts <<'EOF'
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  server: {
    port: 5173
  },
  build: {
    outDir: "dist"
  }
});
EOF

# index.html
cat > index.html <<'EOF'
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>Technical Leader — Portfolio</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>
EOF

# Source files
mkdir -p src/components src/styles

cat > src/main.tsx <<'EOF'
import React from "react";
import { createRoot } from "react-dom/client";
import App from "./App";
import "./styles/index.css";

const root = createRoot(document.getElementById("root") as HTMLElement);
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOF

cat > src/App.tsx <<'EOF'
import React from "react";
import Header from "./components/Header";
import Hero from "./components/Hero";
import About from "./components/About";
import Projects from "./components/Projects";
import Contact from "./components/Contact";

export default function App() {
  return (
    <div className="app">
      <Header />
      <main>
        <Hero />
        <About />
        <Projects />
        <Contact />
      </main>
      <footer className="site-footer">© {new Date().getFullYear()} Technical Leader</footer>
    </div>
  );
}
EOF

cat > src/components/Header.tsx <<'EOF'
import React from "react";

export default function Header() {
  return (
    <header className="site-header">
      <div className="container">
        <h1 className="brand">Your Name</h1>
        <nav>
          <a href="#about">About</a>
          <a href="#projects">Work</a>
          <a href="#contact">Contact</a>
        </nav>
      </div>
    </header>
  );
}
EOF

cat > src/components/Hero.tsx <<'EOF'
import React from "react";

export default function Hero() {
  return (
    <section className="hero container" id="hero">
      <h2>Technical Leader</h2>
      <p>
        Build and lead engineering teams that deliver reliable, scalable systems. I focus on technical strategy, architecture,
        developer experience, and measurable business outcomes.
      </p>
      <p>
        <a className="primary" href="#contact">Get in touch</a>
      </p>
    </section>
  );
}
EOF

cat > src/components/About.tsx <<'EOF'
import React from "react";

export default function About() {
  return (
    <section className="about container" id="about">
      <h3>About</h3>
      <p>
        Concise summary of leadership approach, technical strengths (system design, distributed systems, cloud, observability),
        and hiring/coaching philosophy. Add 3–5 bullets or short paragraphs here about outcomes you've delivered.
      </p>
    </section>
  );
}
EOF

cat > src/components/Projects.tsx <<'EOF'
import React from "react";

type Project = {
  title: string;
  summary: string;
  link?: string;
};

const sample: Project[] = [
  { title: "Platform Modernization", summary: "Led migration to microservices and improved deployment velocity by X%." },
  { title: "Observability & SRE", summary: "Introduced SLOs and reduced P1 time-to-resolve by Y%." }
];

export default function Projects() {
  return (
    <section className="projects container" id="projects">
      <h3>Selected Work</h3>
      <div className="grid">
        {sample.map((p) => (
          <article key={p.title} className="card">
            <h4>{p.title}</h4>
            <p>{p.summary}</p>
            {p.link && (
              <p>
                <a href={p.link} target="_blank" rel="noreferrer">Read more</a>
              </p>
            )}
          </article>
        ))}
      </div>
    </section>
  );
}
EOF

cat > src/components/Contact.tsx <<'EOF'
import React from "react";

export default function Contact() {
  return (
    <section className="contact container" id="contact">
      <h3>Contact</h3>
      <p>Email: <a href="mailto:you@example.com">you@example.com</a></p>
      <p>LinkedIn: <a href="https://www.linkedin.com/in/yourprofile" target="_blank" rel="noreferrer">yourprofile</a></p>
      <p>GitHub: <a href="https://github.com/yourusername" target="_blank" rel="noreferrer">yourusername</a></p>
    </section>
  );
}
EOF

# Styles
cat > src/styles/index.css <<'EOF'
:root{
  --bg:#0f1720;
  --card:#0b1220;
  --text:#e6eef8;
  --muted:#9fb0c8;
  --accent:#2dd4bf;
  --container-width:1000px;
  font-family: Inter, ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--text);line-height:1.6}
.container{max-width:var(--container-width);margin:0 auto;padding:2rem}
.site-header{border-bottom:1px solid rgba(255,255,255,0.04)}
.site-header .container{display:flex;align-items:center;justify-content:space-between}
.brand{margin:0;font-size:1.1rem}
.site-header nav a{color:var(--muted);margin-left:1rem;text-decoration:none}
.hero{padding:4rem 0}
.primary{display:inline-block;padding:.5rem 1rem;background:var(--accent);color:#04201f;border-radius:6px;text-decoration:none}
.projects .grid{display:grid;grid-template-columns:1fr 1fr;gap:1rem}
.card{background:var(--card);padding:1rem;border-radius:8px}
.site-footer{text-align:center;padding:2rem 0;color:var(--muted)}
@media (max-width:700px){
  .projects .grid{grid-template-columns:1fr}
  .container{padding:1rem}
}
EOF

# .gitignore
cat > .gitignore <<'EOF'
node_modules
dist
.env
.vscode
.DS_Store
EOF

# README.md (markdown block)
cat > README.md <<'EOF'
# Technical Leader Portfolio (React + TypeScript + Vite)

This is a minimal portfolio scaffold intended for a technical leader — focused on a clear narrative: leadership, strategy, key projects, and contact info.

Getting started:
1. Install dependencies:
   npm install

2. Run dev server:
   npm run dev

3. Build:
   npm run build

Branch/Deploy:
- I recommend creating a branch named `site/react-ts` and pushing the files there.
- CI workflow (provided) will build and deploy to GitHub Pages using the gh-pages branch.

Customize:
- Replace the copy in `src/components/*` with your content.
- Add images, GitHub projects, and links where appropriate.

Notes:
- This project uses Vite + React + TypeScript.
- The GitHub Actions workflow will build and push the `dist/` output to the `gh-pages` branch.
EOF

# GitHub Actions workflow (deploy to gh-pages)
mkdir -p .github/workflows
cat > .github/workflows/ci-and-deploy.yml <<'EOF'
name: CI and Deploy to gh-pages

on:
  push:
    branches:
      - site/react-ts
      - main

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: 18

      - name: Install dependencies
        run: npm ci

      - name: Build
        run: npm run build

      - name: Deploy to gh-pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./dist
          publish_branch: gh-pages
          commit_message: "chore: deploy site to gh-pages [skip ci]"
EOF

# Create the zip
cd ..
zip -r "$ZIP_OUT" "$ROOT_DIR" >/dev/null

echo "Created $ZIP_OUT"
echo "Unzip with: unzip $ZIP_OUT"
EOF