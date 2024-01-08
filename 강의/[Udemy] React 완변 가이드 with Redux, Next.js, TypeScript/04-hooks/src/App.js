import React, { useContext } from "react";

import Login from "./components/Login/Login";
import Home from "./components/Home/Home";
import MainHeader from "./components/MainHeader/MainHeader";
import AuthContext from "./state/auth-context";

function App() {
  const authContext = useContext(AuthContext);
  return (
    <>
      <MainHeader
        isAuthenticated={authContext.isLoggedIn}
        onLogout={authContext.onLogOut}
      />{" "}
      <main>
        {!authContext.isLoggedIn && <Login />}
        {authContext.isLoggedIn && <Home />}
      </main>
    </>
  );
}

export default App;
