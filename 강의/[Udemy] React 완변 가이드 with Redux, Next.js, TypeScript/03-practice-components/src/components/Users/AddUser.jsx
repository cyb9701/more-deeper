import React, { useRef, useState } from "react";
import Button from "../UI/Button.jsx";
import UserInput from "../UI/UserInput.jsx";
import Card from "../UI/Card.jsx";
import ErrorModal from "../UI/ErrorModal.jsx";
import classes from "./AddUser.module.css";

const AddUser = (props) => {
  const usernameRef = useRef(null);
  const [enteredAge, setEnteredAge] = useState("");
  const [error, setError] = useState();

  function handleAgeChange(submittedAge) {
    const result = submittedAge.target.value.replace(/\D/g, "");
    setEnteredAge(result);
  }

  function handleUserAdd(event) {
    event.preventDefault();

    const newUsername = usernameRef.current.value.trim();
    const newAge = enteredAge.trim();

    if (newUsername.length === 0 || newAge.length === 0) {
      setError({
        title: "Invalid input",
        content: "Please enter a valid name and age (non-empty values)",
      });
      return;
    } else if (+newAge < 1) {
      setError({
        title: "Invalid age",
        content: "Please enter a valid age (> 0)",
      });
      return;
    }

    const newUser = {
      key: Date(),
      name: newUsername,
      age: newAge,
    };
    props.onUserAdd(newUser);
    usernameRef.current.value = null;
    setEnteredAge("");
  }

  function handleError() {
    setError();
  }

  return (
    <div>
      {error ? (
        <ErrorModal
          title={error?.title}
          content={error?.content}
          onClick={handleError}
        />
      ) : null}
      <Card className={classes.input}>
        <form onSubmit={handleUserAdd}>
          <UserInput id="username" label="Username" ref={usernameRef} />
          <UserInput
            id="age"
            label="Age (Years)"
            value={enteredAge}
            onChange={handleAgeChange}
          />
          <Button type={"submit"}>Add User</Button>
        </form>
      </Card>
    </div>
  );
};

export default AddUser;
