import { useState } from 'react';

const useInput = (onValidateValue) => {
  const [enteredValue, setEnteredValue] = useState('');
  const [isTouched, setIsTouched] = useState(false);

  const isValueValid = onValidateValue(enteredValue);
  const hasError = !isValueValid && isTouched;

  const handleValueChange = (event) => {
    setEnteredValue(event.currentTarget.value);
  };

  const handleInputBlur = () => {
    setIsTouched(true);
  };

  function reset() {
    setEnteredValue('');
    setIsTouched(false);
  }

  return {
    value: enteredValue,
    isValueValid,
    hasError,
    handleValueChange,
    handleInputBlur,
    reset,
  };
};

export default useInput;
