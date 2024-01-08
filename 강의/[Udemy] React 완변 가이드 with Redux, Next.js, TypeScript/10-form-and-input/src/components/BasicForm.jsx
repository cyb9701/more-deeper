import React from 'react';
import useInput from '../hooks/use-input';

function BasicForm() {
  const {
    value: enteredFirstName,
    isValueValid: isFirstNameValid,
    hasError: hasFirstNameInputError,
    handleValueChange: handleFirstNameChange,
    handleInputBlur: handleFirstNameInputBlur,
    reset: resetFirstNameInput,
  } = useInput((value) => value.trim() !== '');
  const {
    value: enteredLastName,
    isValueValid: isLastNameValid,
    hasError: hasLastNameInputError,
    handleValueChange: handleLastNameChange,
    handleInputBlur: handleLastNameInputBlur,
    reset: resetLastNameInput,
  } = useInput((value) => value.trim() !== '');
  const {
    value: enteredEmail,
    isValueValid: isEmailValid,
    hasError: hasEmailInputError,
    handleValueChange: handleEmailChange,
    handleInputBlur: handleEmailInputBlur,
    reset: resetEmailInput,
  } = useInput((value) => value.trim().length > 3 && value.includes('@'));

  const formsValid = isFirstNameValid && isLastNameValid && isEmailValid;

  function handleSubmit(event) {
    event.preventDefault();

    if (isFirstNameValid && isLastNameValid && isEmailValid) {
      resetFirstNameInput();
      resetLastNameInput();
      resetEmailInput();
    }
  }

  const firstNameInputClassName = hasFirstNameInputError ? 'form-control invalid' : 'form-control';
  const lastNameInputClassName = hasLastNameInputError ? 'form-control invalid' : 'form-control';
  const emailInputClassName = hasEmailInputError ? 'form-control invalid' : 'form-control';

  return (
    <form onSubmit={handleSubmit}>
      <div className='control-group'>
        <div className={firstNameInputClassName}>
          <label htmlFor='name'>
            First Name
            <input
              type='text'
              id='name'
              value={enteredFirstName}
              onChange={handleFirstNameChange}
              onBlur={handleFirstNameInputBlur}
            />
          </label>
          {hasFirstNameInputError && <p className='error-text'>Must be not empty</p>}
        </div>
        <div className={lastNameInputClassName}>
          <label htmlFor='name'>
            Last Name
            <input
              type='text'
              id='name'
              value={enteredLastName}
              onChange={handleLastNameChange}
              onBlur={handleLastNameInputBlur}
            />
          </label>
          {hasLastNameInputError && <p className='error-text'>Must be not empty</p>}
        </div>
      </div>
      <div className={emailInputClassName}>
        <label htmlFor='name'>
          E-Mail Address
          <input
            type='text'
            id='name'
            value={enteredEmail}
            onChange={handleEmailChange}
            onBlur={handleEmailInputBlur}
          />
          {hasEmailInputError && <p className='error-text'>Must be not empty and contain @</p>}
        </label>
      </div>
      <div className='form-actions'>
        <button type='submit' disabled={!formsValid}>
          Submit
        </button>
      </div>
    </form>
  );
}

export default BasicForm;
