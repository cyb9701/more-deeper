import React, { useState } from 'react';
import Header from './components/Layout/Header';
import Meals from './components/Meals/Meals';
import Cart from './components/Cart/Cart';
import CartContextProvider from './store/CartContextProvider';

function App() {
  const [cartIsShown, setCartIsShown] = useState(false);

  function handleCartState(value) {
    setCartIsShown(value);
  }

  return (
    <CartContextProvider>
      {cartIsShown && <Cart onCloseCart={() => handleCartState(false)} />}
      <Header onOpenCart={() => handleCartState(true)} />
      <main>
        <Meals />
      </main>
    </CartContextProvider>
  );
}

export default App;
