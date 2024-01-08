import React from 'react';
import classes from './Header.module.css';
import HeaderCartButton from './HeaderCartButton';

function Header(props) {
  return (
    <>
      <header className={classes.header}>
        <h1>React Meals</h1>
        <HeaderCartButton onOpenCart={props.onOpenCart} />
      </header>
      <div className={classes['main-image']}>
        <img src='src/assets/meals.jpg' alt='A table full of delicious food!' />
      </div>
    </>
  );
}

export default Header;
