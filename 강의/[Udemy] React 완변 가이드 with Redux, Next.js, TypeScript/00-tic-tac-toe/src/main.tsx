// React.
import React from "react";
// 웹 브라우저와 상호작용하는 React의 라이브러리(React DOM).
import ReactDOM from "react-dom/client";
// 컴포넌트의 스타일.
import "./App.css";
// App.js에서 만들어진 컴포넌트.
import App from "./App.tsx";

ReactDOM.createRoot(document.getElementById("root") as HTMLElement).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
