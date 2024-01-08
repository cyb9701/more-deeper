import React, {
  useContext,
  useEffect,
  useReducer,
  useRef,
  useState,
} from "react";

import Card from "../UI/Card/Card";
import Button from "../UI/Button/Button";
import classes from "./Login.module.css";
import AuthContext from "../../state/auth-context";
import Input from "../UI/Input/Input";

const emailReducer = (state, action) => {
  if (action.type === "INPUT_CHANGE") {
    return {
      value: action.value,
      isValid: action.value.includes("@") || action.value.length === 0,
    };
  } else if (action.type === "INPUT_BLUR") {
    return {
      value: state.value,
      isValid: state.value.includes("@") || state.value.length === 0,
    };
  }
};

const passwordReducer = (state, action) => {
  if (action.type === "INPUT_CHANGE") {
    return {
      value: action.value,
      isValid: action.value.trim().length > 6 || action.value.length === 0,
    };
  } else if (action.type === "INPUT_BLUR") {
    return {
      value: state.value,
      isValid: state.value.trim().length > 6 || state.value.length === 0,
    };
  }
};

const Login = () => {
  const [formIsValid, setFormIsValid] = useState(false);
  const [emailState, dispatchEmail] = useReducer(emailReducer, {
    value: "",
    isValid: true,
  });
  const [passwordState, dispatchPassword] = useReducer(passwordReducer, {
    value: "",
    isValid: true,
  });

  const authContext = useContext(AuthContext);
  const emailRef = useRef(null);
  const passwordRef = useRef(null);

  // useEffect 중복 요청을 피하는 방법.
  // emailValid 와 passwordValid는 별칭이다.
  const { isValid: emailValid, value: emailValue } = emailState;
  const { isValid: passwordValid, value: passwordValue } = passwordState;

  useEffect(() => {
    const timer = setTimeout(() => {
      setFormIsValid(
        emailValid &&
          emailValue.length !== 0 &&
          passwordValid &&
          passwordValue.length !== 0
      );
    }, 500);
    return () => {
      clearTimeout(timer);
    };
  }, [emailValid, passwordValid]);

  const emailChangeHandler = (event) => {
    dispatchEmail({ type: "INPUT_CHANGE", value: event.target.value });
  };

  const passwordChangeHandler = (event) => {
    dispatchPassword({ type: "INPUT_CHANGE", value: event.target.value });
  };

  const validateEmailHandler = () => {
    dispatchEmail({ type: "INPUT_BLUR" });
  };

  const validatePasswordHandler = () => {
    dispatchPassword({ type: "INPUT_BLUR" });
  };

  const submitHandler = (event) => {
    event.preventDefault();

    if (formIsValid) {
      authContext.onLogIn(emailState.value, passwordState.value);
    } else if (!emailValid || emailValue.length === 0) {
      emailRef.current.focus();
    } else if (!passwordValid || passwordValue.length === 0) {
      passwordRef.current.focus();
    }
  };

  return (
    <Card className={classes.login}>
      <form onSubmit={submitHandler}>
        <Input
          ref={emailRef}
          isValid={emailState.isValid}
          id="email"
          label="E-Mail"
          type="email"
          value={emailState.value}
          onChange={emailChangeHandler}
          onBlur={validateEmailHandler}
        />
        <Input
          ref={passwordRef}
          isValid={passwordState.isValid}
          id="password"
          label="Password"
          type="password"
          value={passwordState.value}
          onChange={passwordChangeHandler}
          onBlur={validatePasswordHandler}
        />
        <div className={classes.actions}>
          <Button type="submit" className={classes.btn}>
            Login
          </Button>
        </div>
      </form>
    </Card>
  );
};

export default Login;
