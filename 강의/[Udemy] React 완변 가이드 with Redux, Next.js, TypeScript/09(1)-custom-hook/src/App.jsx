import React from 'react';
import BackwardCounter from './components/BackwardCounter.jsx';
import ForwardCounter from './components/ForwardCounter.jsx';

function App() {
  return (
    <React.Fragment>
      <ForwardCounter />
      <BackwardCounter />
    </React.Fragment>
  );
}

export default App;
