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