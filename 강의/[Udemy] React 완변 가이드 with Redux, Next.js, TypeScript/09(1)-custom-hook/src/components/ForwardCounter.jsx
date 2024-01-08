import React from 'react';

import Card from './Card';
import userCounter from '../hooks/user-counter';

function ForwardCounter() {
  const counter = userCounter(true);

  return <Card>{counter}</Card>;
}

export default ForwardCounter;
