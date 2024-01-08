import React from 'react';

import Card from './Card';
import userCounter from '../hooks/user-counter';

function BackwardCounter() {
  const counter = userCounter(false);

  return <Card>{counter}</Card>;
}

export default BackwardCounter;
