import React, { useCallback, useEffect, useState } from 'react';

import MoviesList from './components/MoviesList';
import AddMovie from './components/AddMovie';
import './App.css';

function App() {
  const [movies, setMovies] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);

  const handleFetchMovies = useCallback(async () => {
    setIsLoading(true);
    setError(null);

    const response = await fetch(
      'https://learn-react-d1e79-default-rtdb.asia-southeast1.firebasedatabase.app/movies.json',
      {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
        },
      },
    );

    if (response.status === 200) {
      const data = await response.json();
      const loadedMovies = [];

      for (const key in data) {
        if (Object.hasOwn(data, key)) {
          loadedMovies.push({
            id: key,
            title: data[key].title,
            openingText: data[key].openingText,
            releaseDate: data[key].releaseDate,
          });
        }
      }
      setMovies(loadedMovies);
    } else {
      setError('Something Is Wrong');
    }

    setIsLoading(false);
  }, []);

  async function handleAddMovie(movie) {
    const response = await fetch(
      'https://learn-react-d1e79-default-rtdb.asia-southeast1.firebasedatabase.app/movies.json',
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(movie),
      },
    );

    if (response.status === 200) {
      await handleFetchMovies();
    }
  }

  useEffect(async () => {
    await handleFetchMovies();
  }, [handleFetchMovies]);

  let content;
  if (isLoading) {
    content = <p>Loading...</p>;
  } else if (error) {
    content = <p>Error...</p>;
  } else if (movies.length > 0) {
    content = <MoviesList movies={movies} />;
  } else {
    content = <p>Found Not Movies</p>;
  }

  return (
    <>
      <section>
        <AddMovie onAddMovie={(movie) => handleAddMovie(movie)} />
      </section>
      <section>
        <button onClick={handleFetchMovies}>Fetch Movies</button>
      </section>
      <section>{content}</section>
    </>
  );
}

export default App;
