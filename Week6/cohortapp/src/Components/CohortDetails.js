// src/Components/CohortDetails.js
import React from 'react';
import styles from './CohortDetails.module.css';

function CohortDetails({ name, startDate, status, coach, trainer }) {
  const titleStyle = {
    color: status.toLowerCase() === 'ongoing' ? 'green' : 'blue',
    fontWeight: 'bold',
    marginBottom: '10px'
  };

  return (
    <div className={styles.box}>
      <h4 style={titleStyle}>{name}</h4>
      <dl>
        <dt>Started On</dt>
        <dd>{startDate}</dd>
        <dt>Current Status</dt>
        <dd>{status}</dd>
        <dt>Coach</dt>
        <dd>{coach}</dd>
        <dt>Trainer</dt>
        <dd>{trainer}</dd>
      </dl>
    </div>
  );
}

export default CohortDetails;
