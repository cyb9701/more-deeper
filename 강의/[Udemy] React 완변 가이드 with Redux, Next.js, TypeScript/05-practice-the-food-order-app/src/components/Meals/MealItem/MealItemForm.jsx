import React, { useRef } from 'react';
import classes from './MealsItemForm.module.css';
import Input from '../../UI/Input';

function MealItemForm(props) {
  const amountRef = useRef();

  function handleAmountSubmit(event) {
    event.preventDefault();
    props.onSubmit(amountRef.current.value);
  }

  return (
    <form className={classes.form} onSubmit={handleAmountSubmit}>
      <Input
        ref={amountRef}
        label='Amount'
        input={{
          id: `amount`,
          type: 'number',
          min: '1',
          max: '5',
          step: '1',
          defaultValue: '1',
        }}
      />
      <button type='submit'>+ Add</button>
    </form>
  );
}

export default MealItemForm;
