import React, { Component } from 'react';

import Users from './Users';
import classes from './UserFinder.module.css';
import UsersContext from '../store/users-context';
import ErrorBoundary from './ErrorBoundary';

// const DUMMY_USERS = [
//   { id: 'u1', name: 'Max' },
//   { id: 'u2', name: 'Manuel' },
//   { id: 'u3', name: 'Julie' },
// ];

class UserFinder extends Component {
  // eslint-disable-next-line react/static-property-placement
  static contextType = UsersContext;

  constructor(props) {
    super(props);
    this.state = {
      filteredUsers: [],
      searchTerm: '',
    };
  }

  componentDidMount() {
    this.setState({
      filteredUsers: this.context.users,
    });
  }

  componentDidUpdate(prevProps, prevState, snapshot) {
    const { searchTerm } = this.state;

    if (prevState.searchTerm !== searchTerm) {
      this.setState({
        filteredUsers: this.context.users.filter((user) => user.name.includes(searchTerm)),
      });
    }
  }

  searchChangeHandler(event) {
    this.setState({ searchTerm: event.target.value });
  }

  render() {
    return (
      <>
        <div className={classes.finder}>
          <input type='search' onChange={this.searchChangeHandler.bind(this)} />
        </div>
        <ErrorBoundary>
          <Users users={this.state.filteredUsers} />
        </ErrorBoundary>
      </>
    );
  }
}

// function UserFinder() {
//   const [filteredUsers, setFilteredUsers] = useState(DUMMY_USERS);
//   const [searchTerm, setSearchTerm] = useState('');
//
//   useEffect(() => {}, [searchTerm]);
//
//   const searchChangeHandler = (event) => {
//     setSearchTerm(event.target.value);
//   };
//
//   return (
//     <>
//       <div className={classes.finder}>
//         <input type='search' onChange={searchChangeHandler} />
//       </div>
//       <Users users={filteredUsers} />
//     </>
//   );
// }

export default UserFinder;
