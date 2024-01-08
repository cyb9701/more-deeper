import React, { forwardRef } from "react";

const UserInput = forwardRef((props, ref) => {
  return (
    <>
      <label htmlFor={props.id}>{props.label}</label>
      <input
        id={props.id}
        value={props.value}
        ref={ref}
        onChange={props.onChange}
      ></input>
    </>
  );
});

export default UserInput;
UserInput.displayName = "UserInput";
