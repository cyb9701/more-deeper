import React, { Component } from 'react';
import classes from './User.module.css';

// eslint-disable-next-line react/prefer-stateless-function
class User extends Component {
  componentWillUnmount() {
    console.log('User.jsx/componentWillUnmount:7', 'Unmount');
  }

  render() {
    const { name } = this.props;
    return <li className={classes.user}>{name}</li>;
  }
}

// function User(props) {
//   return <li className={classes.user}>{props.name}</li>;
// }

export default User;
