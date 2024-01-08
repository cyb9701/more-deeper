## DOM API

- Documnet Object Model, Application Programming Interface
  - Document: HTML에 들어있는 여러 가지 object model
  - Object Model: div 요소, span 요소 혹은 input 요소 등

## `querySelector()`

- HTML 요소(Element) 1개 검색/찾기

```js
const boxEl = document.querySelector('.box');
```

## `addEventListener()`

- 핸들러(Handler, 실행할 함수)

```js
box.addEventListener('click', function () {
  console.log('click');
});
```

## `classList`

- 요소의 클래스 정보 객체 활용

```js
boxEl.classList.add('active');
let isContains = boxEl.classList.contains('active');
console.log(isContainers); // true

boxEl.classList.remove('active');
isContainers = boxEl.classList.containers('active');
console.log(isContainers); // false
```

```html
<div class="box active"></div>
```

## `querySelectorAll()`

- HTML 요소(Element) 모두 검색/찾기

```js
const boxEls = querySelectorAll('.box');
```

## `forEach()`

- 요소들을 반복해서 함수 실행
- 익명 함수를 인수로 추가
- 첫 번째 매개변수: 반복 중인 요소
- 두 번째 매개변수: 반복 중인 번호

```js
boxEls.forEach(function (boxEl, index) {
  boxEl.classList.add(`order-${index + 1}`);
  console.log(index, boxEl);
});
```

## `textContent`

- Getter
- 값을 얻는 용도

```js
console.log(boxEl.textContent); // Box!!
```

- Setter
- 값을 지정한는 용도

```js
boxEl.textContent = 'choi';
console.log(boxEl.textContent); // choi
```
