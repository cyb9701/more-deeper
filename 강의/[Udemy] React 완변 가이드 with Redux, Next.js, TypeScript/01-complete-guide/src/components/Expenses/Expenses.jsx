import "./Expenses.css";
import Card from "../UI/Card.jsx";
import ExpensesFilter from "./ExpensesFilter.jsx";
import { useState } from "react";
import ExpensesList from "./ExpensesList.jsx";
import Chat from "../Chat/Chat.jsx";

const Expenses = (props) => {
  const [filter, setFilter] = useState("2023");

  const handleFilterChange = (value) => {
    setFilter(value);
  };

  const filteredExpenses = props.items.filter((expense) => {
    return expense.date.getFullYear() === Number(filter);
  });

  return (
    <Card className="expenses">
      <ExpensesFilter selected={filter} onFilterChange={handleFilterChange} />
      {filteredExpenses.length > 0 && <Chat items={filteredExpenses} />}
      <ExpensesList items={filteredExpenses} />
    </Card>
  );

  // return (
  //   <Card className="expenses">
  //     <ExpenseItem
  //       date={props.items[0].date}
  //       title={props.items[0].title}
  //       amount={props.items[0].amount}
  //     />
  //     <ExpenseItem
  //       date={props.items[1].date}
  //       title={props.items[1].title}
  //       amount={props.items[1].amount}
  //     />
  //     <ExpenseItem
  //       date={props.items[2].date}
  //       title={props.items[2].title}
  //       amount={props.items[2].amount}
  //     />
  //     <ExpenseItem
  //       date={props.items[3].date}
  //       title={props.items[3].title}
  //       amount={props.items[3].amount}
  //     />
  //   </Card>
  // );
};

export default Expenses;
