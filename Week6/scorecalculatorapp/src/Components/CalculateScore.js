import React from 'react';
import '../Stylesheets/mystyle.css';

function CalculateScore() {
  const name = "Aditya";
  const school = "Netaji Subhash Engineering College";
  const total = 480;
  const goal = 600;
  const avg = total / 6;

  return (
    <div className="score-container">
      <h2>Student Score Card</h2>
      <p><strong>Name:</strong> {name}</p>
      <p><strong>School:</strong> {school}</p>
      <p><strong>Total Score:</strong> {total}</p>
      <p><strong>Goal:</strong> {goal}</p>
      <p><strong>Average Score:</strong> {avg}</p>
    </div>
  );
}

export default CalculateScore;
