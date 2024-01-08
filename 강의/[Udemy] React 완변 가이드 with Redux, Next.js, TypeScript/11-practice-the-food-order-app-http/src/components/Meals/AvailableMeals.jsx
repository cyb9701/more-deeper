import React, { useEffect, useState } from 'react';

import Card from '../UI/Card';
import MealItem from './MealItem/MealItem';
import classes from './AvailableMeals.module.css';

function AvailableMeals() {
  const [meals, setMeals] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [fetchError, setFetchError] = useState(null);

  async function handleFetch() {
    setFetchError(null);
    const response = await fetch(
      'https://learn-react-d1e79-default-rtdb.asia-southeast1.firebasedatabase.app/meals.json',
    );

    if (response.status === 200) {
      const data = await response.json();
      const loadedMeals = [];

      for (const key in data) {
        loadedMeals.push({
          id: key,
          name: data[key].name,
          description: data[key].description,
          price: data[key].price,
        });
      }

      setMeals(loadedMeals);
      setIsLoading(false);
    } else {
      throw Error('Error');
    }
  }

  useEffect(() => {
    handleFetch().catch((error) => {
      setFetchError(error.message);
    });
  }, []);

  if (fetchError) {
    return (
      <section className={classes.mealsError}>
        <p>{fetchError}.....</p>
      </section>
    );
  }

  if (isLoading) {
    return (
      <section className={classes.mealsLoading}>
        <p>Loading.....</p>
      </section>
    );
  }

  const mealsList = meals.map((meal) => (
    <MealItem
      key={meal.id}
      id={meal.id}
      name={meal.name}
      description={meal.description}
      price={meal.price}
    />
  ));

  return (
    <section className={classes.meals}>
      <Card>
        <ul>{mealsList}</ul>
      </Card>
    </section>
  );
}

export default AvailableMeals;
