import React, { useMemo } from 'react';

const DemoOutput = (props) => {
  const { show } = props;

  return useMemo(() => {
    console.log('DemoOutput.jsx/DemoOutput:4', 'Demo Running');

    return <p>{show ? 'New Text' : ''}</p>;
  }, [show]);
};

export default DemoOutput;
