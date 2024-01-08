import "./NewExpense.css";
import ExpenseForm from "./ExpenseFosrm.jsx";
import { useState } from "react";

const NewExpense = (props) => {
  const [isEditing, setIsEditing] = useState(false);

  function handleNewExpenseSubmit(newExpense) {
    const newValue = {
      id: Math.random(),
      ...newExpense,
    };
    props.onExpenseAdd(newValue);
    handleEditingStop();
  }

  function handleEditingStart() {
    setIsEditing(true);
  }

  function handleEditingStop() {
    setIsEditing(false);
  }

  return (
    <div className="new-expense">
      {!isEditing ? (
        <button type="button" onClick={handleEditingStart}>
          Add New Expense
        </button>
      ) : (
        <ExpenseForm
          onNewExpenseSubmit={function (newExpense) {
            handleNewExpenseSubmit(newExpense);
          }}
          onCancel={handleEditingStop}
        />
      )}
    </div>
  );
};

export default NewExpense;
