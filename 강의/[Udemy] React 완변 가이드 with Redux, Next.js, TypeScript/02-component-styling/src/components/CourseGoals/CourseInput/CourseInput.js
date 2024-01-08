import React, {useState} from 'react';
import Button from '../../UI/Button/Button';
import styles from './CourseInput.module.css';

const CourseInput = (props) => {
    const [enteredValue, setEnteredValue] = useState('');
    const [isValid, setIsValid] = useState(true);

    const goalInputChangeHandler = (event) => {
        const value = event.target.value;

        setEnteredValue(value);

        if (value.trim().length > 0 && !isValid) {
            setIsValid(true);
        }
    };

    const formSubmitHandler = (event) => {
        event.preventDefault();

        if (enteredValue.trim().length === 0) {
            setIsValid(false);
            return;
        }

        props.onAddGoal(enteredValue);
        setEnteredValue('');
    };

    // css를 동적으로 설정하는 방법
    // return (<form onSubmit={formSubmitHandler}>
    //     <div className={`form-control ${isValid ? '' : 'invalid'}`}>
    //         <label className={`form-control ${isValid ? '' : 'invalid'}`}>Course Goal</label>
    //         <input
    //             type='text'
    //             value={enteredValue}
    //             onChange={goalInputChangeHandler}
    //         />
    //     </div>
    //     <Button type='submit'>Add Goal</Button>
    // </form>);

    // styled-components package 사용법.
    // return (<form onSubmit={formSubmitHandler}>
    //     <FormControl valid={isValid}>
    //         <label>Course Goal</label>
    //         <input type='text' value={enteredValue} onChange={goalInputChangeHandler}/>
    //     </FormControl>
    //     <Button type='submit'>Add Goal</Button>
    // </form>);

    // css 모듈 사용법.
    // styles['form-control'] 사용하는 이유는 유효하지 않는 속성이기 때문이다.
    // .formControl 이면 styles.formControl 으로 사용해도 된다.
    return (<form onSubmit={formSubmitHandler}>
        <div className={`${styles['form-control']} ${!isValid&&styles['invalid']}`}>
            <label>Course Goal</label>
            <input type='text' value={enteredValue} onChange={goalInputChangeHandler}/>
        </div>
        <Button type='submit'>Add Goal</Button>
    </form>);
};

// const FormControl = styled.div`
//   margin: 0.5rem 0;
//
//   & label {
//     font-weight: bold;
//     display: block;
//     margin-bottom: 0.5rem;
//     color: ${props => (props.valid ? 'black' : 'red')};
//   }
//
//   & input {
//     display: block;
//     width: 100%;
//     border: 1px solid ${props => props.valid ? '#ccc' : 'red'};
//     background: ${props => props.valid ? 'transparent' : '#ffa3a3'};
//     font: inherit;
//     line-height: 1.5rem;
//     padding: 0 0.25rem;
//   }
//
//   & input:focus {
//     outline: none;
//     background: #fad0ec;
//     border-color: #8b005d;
//   }
// `;

export default CourseInput;
