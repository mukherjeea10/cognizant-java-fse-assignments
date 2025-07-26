// src/App.js
import React from 'react';
import CohortDetails from './Components/CohortDetails';
import styles from './Components/CohortDetails.module.css';

function App() {
  return (
    <div style={{ padding: '20px' }}>
      <h2 style={{ fontWeight: 'bold' }}>Cohorts Details</h2>
      <div className={styles.container}>
        <CohortDetails
          name="BATCH23FSD001 - MERN Stack"
          startDate="12-Jan-2023"
          status="Scheduled"
          coach="Aniket Das"
          trainer="Aditya Mukherjee"
        />
        <CohortDetails
          name="BATCH23JAVA002 - Java Backend"
          startDate="25-Feb-2023"
          status="Ongoing"
          coach="Priya Sharma"
          trainer="Ayan Bantu"
        />
        <CohortDetails
          name="BATCH23UI003 - UI/UX Design"
          startDate="10-Mar-2023"
          status="Ongoing"
          coach="Rajat Mehta"
          trainer="Tuhin Paka"
        />
      </div>
    </div>
  );
}

export default App;
