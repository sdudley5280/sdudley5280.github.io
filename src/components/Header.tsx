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