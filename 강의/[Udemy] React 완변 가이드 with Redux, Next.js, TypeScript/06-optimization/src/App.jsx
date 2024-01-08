import React, { useCallback, useState } from 'react';

import './App.css';
import Button from './components/UI/Button/Button';
import DemoOutput from './components/Demo/DemoOutput';

function App() {
  const [allowToggle, setAllowToggle] = useState(false);
  const [showToggle, setShowToggle] = useState(false);

  console.log('App.jsx/App:9', 'App Running');

  const handleAllowChange = () => {
    setAllowToggle((previousValue) => !previousValue);
  };

  const handleToggleChange = useCallback(() => {
    if (allowToggle) {
      setShowToggle((previousValue) => !previousValue);
    }
  }, [allowToggle]);

  return (
    <div className='app'>
      <h1>Hi there!</h1>
      <DemoOutput show={showToggle} />
      <Button onClick={handleAllowChange}>Allow Button</Button>
      <Button onClick={handleToggleChange}>Toggle Button</Button>
    </div>
  );
}

export default App;
