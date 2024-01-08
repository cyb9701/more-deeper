import React, { useContext } from 'react';
import classes from './Cart.module.css';
import Modal from '../UI/Modal';
import CartContext from '../../store/cart-context';
import CartItem from './CartItem';

function Card(props) {
  const cartContext = useContext(CartContext);
  const { items } = cartContext;
  const totalAmount = `$${cartContext.totalAmount.toFixed(2)}`;

  function handleAdd(item) {
    cartContext.onAddItem({
      ...item,
      amount: 1,
    });
  }

  function handleRemove(id) {
    cartContext.onRemoveItem(id);
  }

  const cartItems = (
    <ul className={classes['cart-items']}>
      {items.map((item) => (
        <CartItem
          key={item.id}
          name={item.name}
          amount={item.amount}
          price={item.price}
          onAdd={() => handleAdd(item)}
          onRemove={() => handleRemove(item.id)}
        />
      ))}
    </ul>
  );

  return (
    <Modal onClose={props.onCloseCart}>
      {cartItems}
      <div className={classes.total}>
        <span>Total Amount</span>
        <span>{totalAmount}</span>
      </div>
      <div className={classes.actions}>
        <button className={classes['button--alt']} type='button' onClick={props.onCloseCart}>
          Close
        </button>
        {items.length > 0 && (
          <button className={classes.button} type='button'>
            Order
          </button>
        )}
      </div>
    </Modal>
  );
}

export default Card;
