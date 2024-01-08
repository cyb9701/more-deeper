import "./Card.css";

function Card(props) {
  // props.children 에도 css를 적용하면서
  // card css를 적용하기 위해서 공백으로 구분.
  const classes = `card ${props.className}`;
  return <div className={classes}>{props.children}</div>;
}

export default Card;
