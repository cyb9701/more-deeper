import { useState } from "react";

// export 키워드를 사용하면 이 함수를 파일 외부에서 접근할 수 있습니다.
// default 키워드는 코드를 사용하는 다른 파일에서 이 함수가 파일의 주요 함수임을 알려줍니다.
export default function Game() {
  // 여러 자식 컴포넌트에서 데이터를 수집하거나, 두 자식 컴포넌트가 서로 통신하도록 하려면, 부모 컴포넌트에서 공유 state를 대신 선언하세요. 부모 컴포넌트는 props를 통해 해당 state를 자식 컴포넌트에 다시 전달할 수 있습니다. 이렇게 하면 자식 컴포넌트가 서로 동기화되고 부모 컴포넌트와도 동기화되도록 유지할 수 있습니다.
  const [history, setHistory] = useState<Array<Array<string | null>>>([
    Array(9).fill(null),
  ]);
  const [currentMove, setCurrentMove] = useState(0);
  const xIsNext = currentMove % 2 === 0;
  const currentSquares = history[currentMove];

  function handlePlay(nextSquares: Array<string | null>) {
    const nextHistory = [...history.slice(0, currentMove + 1), nextSquares];
    setHistory(nextHistory);
    setCurrentMove(nextHistory.length - 1);
  }

  function jumpTo(nextIndex: number) {
    setCurrentMove(nextIndex);
  }

  const moves = history.map((_, index) => {
    let description;
    if (index > 0) {
      description = "Go to move #" + index;
    } else {
      description = "Go to game start";
    }
    return (
      <li key={index}>
        <button onClick={() => jumpTo(index)}>{description}</button>
      </li>
    );
  });

  return (
    <div className="game">
      <div className="game-board">
        <Board
          xIsNext={xIsNext}
          squares={currentSquares}
          onPlay={(newValue) => handlePlay(newValue)}
        />
      </div>
      <div className="game-infro">
        <ol>{moves}</ol>
      </div>
    </div>
  );
}

type BoardParameters = {
  xIsNext: boolean;
  squares: Array<string | null>;
  onPlay: (nextSquares: Array<string | null>) => void;
};

function Board({ xIsNext, squares, onPlay }: BoardParameters) {
  const winner = calculateWinner(squares);
  let status: string;
  if (winner) {
    status = `Winner: ${winner}`;
  } else {
    status = `Next player: ${xIsNext ? "X" : "O"}`;
  }

  // JaveScript는 클로저를 지원하므로 내부함수가 (예: handleClick) 외부 함수 (예: Board)에 정의된 변수 및 함수에 엑세스할 수 있습니다. handleClick 함수는 squares 의 state를 읽고 setSquares 메서드를 호출할 수 있는데, 이 두 함수는 Board 함수 내부에 정의되어 있기 때문입니다.
  function handleClick(index: number) {
    if (squares[index] || winner) {
      return;
    }

    // handleClick 함수는 JavaScript의 slice() 배열 메서드를 사용하여 squares 배열의 사본(nextSquares)을 생성합니다. 그런 다음 handleClick 함수는 nextSquares 배열의 첫 번째 사각형([0] 인덱스)에 X를 추가하여 업데이트합니다.
    const nextSquares = squares.slice();

    if (xIsNext) {
      nextSquares[index] = "X";
    } else {
      nextSquares[index] = "O";
    }
    onPlay(nextSquares);
  }

  // className="square"는 버튼 prop 또는 프로퍼티로, CSS에 버튼의 스타일을 지정하는 방법을 알려줍니다.
  // React 컴포넌트는 두 개의 버튼처럼 인접한 여러 개의 JSX 엘리먼트가 아닌 단일 JSX 엘리먼트를 반환해야 합니다.
  // 이 문제를 해결하려면 fragments(<> 와 </>)를 사용하여 다음과 같이 여러 개의 인접한 JSX 엘리먼트를 감쌀 수 있습니다:
  return (
    <>
      <div className="status">{status}</div>
      <div className="board-row">
        <Square value={squares[0]} onSquareClick={() => handleClick(0)} />
        <Square value={squares[1]} onSquareClick={() => handleClick(1)} />
        <Square value={squares[2]} onSquareClick={() => handleClick(2)} />
      </div>
      <div className="board-row">
        <Square value={squares[3]} onSquareClick={() => handleClick(3)} />
        <Square value={squares[4]} onSquareClick={() => handleClick(4)} />
        <Square value={squares[5]} onSquareClick={() => handleClick(5)} />
      </div>
      <div className="board-row">
        <Square value={squares[6]} onSquareClick={() => handleClick(6)} />
        <Square value={squares[7]} onSquareClick={() => handleClick(7)} />
        <Square value={squares[8]} onSquareClick={() => handleClick(8)} />
      </div>
    </>
  );
}

type SquareParameter = {
  value: string | null;
  onSquareClick: () => void;
};

function Square({ value, onSquareClick }: SquareParameter) {
  return (
    <button className="square" onClick={onSquareClick}>
      {value}
    </button>
  );
}

function calculateWinner(squares: Array<string | null>): string | null {
  const lines = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];
  for (let i = 0; i < lines.length; i++) {
    const [a, b, c] = lines[i];
    if (squares[a] && squares[a] == squares[b] && squares[a] == squares[c]) {
      return squares[a];
    }
  }
  return null;
}
