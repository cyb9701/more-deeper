import Expenses from "./components/Expenses/Expenses.jsx";
import NewExpense from "./components/NewExpense/NewExpense.jsx";
import { useState } from "react";

function App() {
  const [expenses, setExpenses] = useState([]);

  const handleExpenseAdd = (newExpense) => {
    setExpenses((pastExpenses) => {
      return [...pastExpenses, newExpense];
    });
  };

  return (
    <>
      <NewExpense onExpenseAdd={handleExpenseAdd} />
      <Expenses items={expenses} />;
    </>
  );
}

export default App;
