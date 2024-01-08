import React from "react";
import "./ChatBar.css";

const ChartBar = (props) => {
  const charBarStyle = {
    height: Math.round((props.value / props.maximum) * 100) + "%",
  };

  return (
    <div className="chart-bar">
      <div className="chart-bar__inner">
        <div className="chart-bar__fill" style={charBarStyle}></div>
      </div>
      <div className="chart-bar__label">{props.label}</div>
    </div>
  );
};

export default ChartBar;
