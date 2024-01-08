import AddUser from "./components/Users/AddUser.jsx";
import UserList from "./components/Users/UserList.jsx";
import { useState } from "react";
import "./App.css";

function App() {
  const [userList, setUserList] = useState([]);

  function handleUserAdd(user) {
    setUserList((prevState) => {
      return [...prevState, user];
    });
  }

  return (
    <div>
      <AddUser onUserAdd={handleUserAdd} />
      <UserList userList={userList} />
    </div>
  );
}

export default App;
