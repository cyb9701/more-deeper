import React from 'react';
import style from './Button.module.css';

const Button = props => {
    return (
        <button type={props.type} className={style.button} onClick={props.onClick}>
            {props.children}
        </button>
    );
};

// styled-components package 사용 방법
// const Button = styled.button`
//   width: 100%;
//   font: inherit;
//   padding: 0.5rem 1.5rem;
//   border: 1px solid #8b005d;
//   color: white;
//   background: #8b005d;
//   box-shadow: 0 0 4px rgba(0, 0, 0, 0.26);
//   cursor: pointer;
//
//   @media (min-width: 768px){
//     width: auto;
//   }
//
//   &:focus {
//     outline: none;
//   }
//
//
//   &:hover
//   &:active {
//     background: #0e1bac;
//     border-color: #52c9c5;
//     box-shadow: 0 0 8px rgba(0, 0, 0, 0.26);
//   }
// `;

export default Button;
