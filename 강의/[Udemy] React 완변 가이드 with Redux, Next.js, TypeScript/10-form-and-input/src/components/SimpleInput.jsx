import React, { useEffect, useState } from 'react';
import useInput from '../hooks/use-input';

function SimpleInput() {
  const [formIsValid, setFormIsValid] = useState(false);
  const {
    value: enteredName,
    isValueValid: isNameValid,
    hasError: hasErrorNameInput,
    handleValueChange: handleNameInputChange,
    handleInputBlur: handleNameInputBlur,
    reset: resetNameInput,
  } = useInput((value) => value.trim() !== '');

  useEffect(() => {
    if (isNameValid) {
      setFormIsValid(true);
    } else {
      setFormIsValid(false);
    }
  }, [isNameValid]);

  const handleChangeName = (event) => {
    handleNameInputChange(event.currentTarget.value);
  };

  const handleNameBlur = () => {
    handleNameInputBlur(true);
  };

  const handleSubmitName = (event) => {
    event.preventDefault();

    if (!isNameValid) {
      return;
    }

    resetNameInput();
  };

  const inputClassName = hasErrorNameInput ? 'form-control invalid' : 'form-control';

  return (
    <form onSubmit={(event) => handleSubmitName(event)}>
      <div className={inputClassName}>
        <label htmlFor='name'>
          Your Name
          <input
            type='text'
            id='name'
            value={enteredName}
            onBlur={handleNameBlur}
            onChange={(event) => handleChangeName(event)}
          />
        </label>
        {hasErrorNameInput && <p className='error-text'>Name must be not empty</p>}
      </div>
      <div className='form-actions'>
        <button type='submit' disabled={!formIsValid}>
          Submit
        </button>
      </div>
    </form>
  );
}

export default SimpleInput;
