import React, { useContext } from 'react';
import classes from './MealItem.module.css';
import MealItemForm from './MealItemForm';
import CartContext from '../../../store/cart-context';

function MealItem(props) {
  const value = props.meal;
  const price = value.price.toFixed(2);
  const cartContext = useContext(CartContext);
  function handleItemAdd(amount) {
    cartContext.onAddItem({
      ...value,
      amount: +amount,
    });
  }

  return (
    <li className={classes.meal}>
      <div>
        <h3>{value.name}</h3>
        <div className={classes.description}>{value.description}</div>
        <div className={classes.price}>{price}</div>
      </div>
      <div>
        <MealItemForm onSubmit={(amount) => handleItemAdd(amount)} />
      </div>
    </li>
  );
}

export default MealItem;
