import React, { useContext, useEffect, useState } from 'react';
import CartIcon from '../Cart/CartIcon';
import CartContext from '../../store/cart-context';
import classes from './HeaderCartButton.module.css';

function HeaderCartButton(props) {
  const cartContext = useContext(CartContext);
  const { items } = cartContext;
  const numberOfCartItems = items.reduce(
    (previousValue, currentValue) => previousValue + currentValue.amount,
    0,
  );

  const [buttonIsHighlighted, setButtonIsHighlighted] = useState(false);

  useEffect(() => {
    let timer;
    if (items.length !== 0) {
      setButtonIsHighlighted(true);
      timer = setTimeout(() => {
        setButtonIsHighlighted(false);
      }, 300);
    }

    return () => {
      clearTimeout(timer);
    };
  }, [items]);

  const buttonClassName = `${classes.button} ${buttonIsHighlighted ? classes.bump : ''}`;

  return (
    <button className={buttonClassName} type='button' onClick={props.onOpenCart}>
      <span className={classes.icon}>
        <CartIcon />
      </span>
      <span>Cart</span>
      <span className={classes.badge}>{numberOfCartItems}</span>
    </button>
  );
}

export default HeaderCartButton;
