import React from "react";
import Card from "./Card.jsx";
import classes from "./ErrorModal.module.css";
import Button from "./Button.jsx";

const ErrorModal = (props) => {
  return (
    <div className={classes.backdrop} onClick={props.onClick}>
      <Card className={classes.modal}>
        <header className={classes.header}>
          <h2>{props.title}</h2>
        </header>
        <div className={classes.content}>
          <p>{props.content}</p>
        </div>
        <footer className={classes.actions}>
          <Button onClick={props.onClick}>Okay</Button>
        </footer>
      </Card>
    </div>
  );
};

export default ErrorModal;
