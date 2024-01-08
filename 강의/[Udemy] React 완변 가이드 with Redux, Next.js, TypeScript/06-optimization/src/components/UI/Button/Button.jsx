import React, { useMemo } from 'react';

import classes from './Button.module.css';

function Button(props) {
  const { type, className, onClick, disabled, children } = props;
  return useMemo(() => {
    console.log('Button.jsx/:7', 'Button Running');
    return (
      <button
        type={type || 'button'}
        className={`${classes.button} ${className}`}
        onClick={onClick}
        disabled={disabled}
      >
        {children}
      </button>
    );
  }, [type, className, onClick, disabled, children]);
}

export default Button;
