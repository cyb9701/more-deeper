import React from "react";
import ChartBar from "./ChartBar.jsx";
import "./Chart.css";

const Chat = (props) => {
  let maximum = 0;
  const chartValues = [
    { label: "1월", value: 0 },
    { label: "2월", value: 0 },
    { label: "3월", value: 0 },
    { label: "4월", value: 0 },
    { label: "5월", value: 0 },
    { label: "6월", value: 0 },
    { label: "7월", value: 0 },
    { label: "8월", value: 0 },
    { label: "9월", value: 0 },
    { label: "10월", value: 0 },
    { label: "11월", value: 0 },
    { label: "12월", value: 0 },
  ];

  for (const item of props.items) {
    const chartValueIndex = item.date.getMonth();
    const itemAmount = item.amount;
    chartValues[chartValueIndex].value += itemAmount;

    if (Number(itemAmount) > maximum) {
      maximum = itemAmount;
    }
  }

  return (
    <div className="chart">
      {chartValues.map((chartValue) => (
        <ChartBar
          key={chartValue.label}
          label={chartValue.label}
          value={chartValue.value}
          maximum={maximum}
        />
      ))}
    </div>
  );
};

export default Chat;
