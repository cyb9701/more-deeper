import { useEffect, useState } from 'react';

const userCounter = (forwards) => {
  const [counter, setCounter] = useState(0);

  useEffect(() => {
    const interval = setInterval(() => {
      setCounter((prevCounter) => {
        if (forwards) {
          return prevCounter + 1;
        }
        return prevCounter - 1;
      });
    }, 1000);

    return () => clearInterval(interval);
  }, [forwards]);

  return counter;
};

export default userCounter;
