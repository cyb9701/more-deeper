import React, { useEffect, useState } from 'react';

import Tasks from './components/Tasks/Tasks';
import NewTask from './components/NewTask/NewTask';
import useHttp from './hooks/use-http';

function App() {
  const [tasks, setTasks] = useState([]);

  function handleTransformTasks(data) {
    const loadedTasks = [];

    for (const taskKey in data) {
      loadedTasks.push({ id: taskKey, text: data[taskKey].text });
    }

    setTasks(loadedTasks);
  }

  const { isLoading, error, request: fetchTasks } = useHttp();

  useEffect(() => {
    fetchTasks(
      {
        url: 'https://learn-react-d1e79-default-rtdb.asia-southeast1.firebasedatabase.app/tasks.json',
      },
      (data) => handleTransformTasks(data),
    );
  }, [
    // 컴포넌트에 지정된 변수 및 함수는 그 컴포넌트에 있는 의존성에 추가가 되어야 한다.
    fetchTasks,
  ]);

  const taskAddHandler = (task) => {
    setTasks((prevTasks) => prevTasks.concat(task));
  };

  return (
    <>
      <NewTask onAddTask={taskAddHandler} />
      <Tasks items={tasks} loading={isLoading} error={error} onFetch={fetchTasks} />
    </>
  );
}

export default App;
