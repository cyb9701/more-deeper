import React from "react";
import Card from "../UI/Card.jsx";
import classes from "./UserList.module.css";

const UserList = (props) => {
  return (
    <Card className={classes.users}>
      <ul>
        {props.userList.map((user) => {
          return (
            <li key={user.key}>
              {user.name} ({user.age} years old)
            </li>
          );
        })}
      </ul>
    </Card>
  );
};

export default UserList;
