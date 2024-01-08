import "./ExpenseForm.css";
import { useState } from "react";

const ExpenseForm = (props) => {
  const initUserInput = {
    enteredTitle: "",
    enteredAmount: "",
    enteredDate: "",
  };

  const [userInput, setUserInput] = useState(initUserInput);
  const handleTargetChange = (event, target) => {
    switch (target) {
      case "title":
        // 이전 값을 사용하면 함수 양식을 사용해서 사용해야한다.
        setUserInput((previousState) => {
          return { ...previousState, enteredTitle: event.target.value };
        });
        break;
      case "amount":
        setUserInput((previousState) => {
          return { ...previousState, enteredAmount: event.target.value };
        });
        break;
      case "date":
        setUserInput((previousState) => {
          return { ...previousState, enteredDate: event.target.value };
        });
        break;
    }
  };

  const handleSubmit = (event) => {
    // form 태그를 통해서 전달할때 전체 화면이 재랜더링 되는 것을 막기 위해서 설정.
    event.preventDefault();

    const expenseData = {
      title: userInput.enteredTitle,
      amount: userInput.enteredAmount,
      date: new Date(userInput.enteredDate),
    };
    props.onNewExpenseSubmit(expenseData);
    setUserInput(initUserInput);
  };

  return (
    <form onSubmit={handleSubmit}>
      <div className="new-expense__controls">
        <div className="new-expense__control">
          <label>Title</label>
          <input
            type="text"
            value={userInput.enteredTitle}
            onChange={(event) => handleTargetChange(event, "title")}
          />
        </div>

        <div className="new-expense__control">
          <label>Amount</label>
          <input
            type="number"
            min="0.01"
            step="0.01"
            value={userInput.enteredAmount}
            onChange={(event) => handleTargetChange(event, "amount")}
          />
        </div>

        <div className="new-expense__control">
          <label>Date</label>
          <input
            type="date"
            min="2020-01-01"
            max="2023-12-31"
            value={userInput.enteredDate}
            onChange={(event) => handleTargetChange(event, "date")}
          />
        </div>
      </div>
      <div className="new-expense__actions">
        <button type="button" onClick={props.onCancel}>
          Cancel
        </button>
        <button type="submit">Add Expense</button>
      </div>
    </form>
  );
};

export default ExpenseForm;
