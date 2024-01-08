import React, { useMemo, useReducer } from 'react';
import CartContext from './cart-context';

const defaultCart = {
  items: [],
  totalAmount: 0,
};
const cartReducer = (state, action) => {
  if (action.type === 'ADD') {
    const updatedTotalAmount = state.totalAmount + action.item.price * action.item.amount;

    const existingItemIndex = state.items.findIndex((item) => item.id === action.item.id);
    const existingItem = state.items[existingItemIndex];

    let updatedItems;

    if (existingItem) {
      updatedItems = [...state.items];
      updatedItems[existingItemIndex] = {
        ...existingItem,
        amount: existingItem.amount + 1,
      };
    } else {
      updatedItems = state.items.concat(action.item);
    }

    return {
      items: updatedItems,
      totalAmount: updatedTotalAmount,
    };
  }
  if (action.type === 'REMOVE') {
    const exitingItemIndex = state.items.findIndex((item) => item.id === action.id);
    const existingItem = state.items[exitingItemIndex];

    const updatedTotalAmount = state.totalAmount - existingItem.price;

    let updatedItems;
    if (existingItem.amount > 1) {
      updatedItems = [...state.items];
      updatedItems[exitingItemIndex] = {
        ...existingItem,
        amount: existingItem.amount - 1,
      };
    } else {
      updatedItems = state.items.filter((item) => item.id !== action.id);
    }
    return {
      items: updatedItems,
      totalAmount: updatedTotalAmount,
    };
  }
  return defaultCart;
};

function CartContextProvider(props) {
  const [cartState, dispatchCart] = useReducer(cartReducer, defaultCart);

  function handleAddItem(item) {
    dispatchCart({ type: 'ADD', item });
  }

  function handleRemoveItem(id) {
    dispatchCart({ type: 'REMOVE', id });
  }

  const cartContextValue = useMemo(
    () => ({
      items: cartState.items,
      totalAmount: cartState.totalAmount,
      onAddItem: handleAddItem,
      onRemoveItem: handleRemoveItem,
    }),
    [cartState],
  );

  return <CartContext.Provider value={cartContextValue}>{props.children}</CartContext.Provider>;
}

export default CartContextProvider;
