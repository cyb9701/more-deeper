import React from 'react';
import { createPortal } from 'react-dom';
import classes from './Modal.module.css';

function Backdrop(props) {
  return (
    <button
      className={classes.backdrop}
      type='button'
      aria-label='button-label'
      onClick={props.onClose}
    />
  );
}

function ModalOverlay({ children }) {
  return <div className={classes.modal}>{children}</div>;
}

function Modal(props) {
  return createPortal(
    <>
      <Backdrop onClose={props.onClose} />
      <ModalOverlay>{props.children}</ModalOverlay>
    </>,
    document.body,
  );
}

export default Modal;
