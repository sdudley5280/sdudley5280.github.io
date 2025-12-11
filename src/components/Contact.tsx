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