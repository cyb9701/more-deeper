import { useCallback, useState } from 'react';

const useHttp = () => {
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);

  const request = useCallback(async (requestConfigure, applyData) => {
    console.log('use-http.jsx/useHttp:7', 'LOADING');

    setIsLoading(true);
    setError(null);

    try {
      const response = await fetch(requestConfigure.url, {
        method: requestConfigure.method ?? 'GET',
        headers: requestConfigure.headers ?? {},
        body: requestConfigure.body ? JSON.stringify(requestConfigure.body) : null,
      });

      if (!response.ok) {
        throw new Error('Request failed!');
      }

      const data = await response.json();
      applyData(data);
    } catch (err) {
      setError(err.message || 'Something went wrong!');
    }
    setIsLoading(false);
  }, []);

  return {
    isLoading,
    error,
    request,
  };
};

export default useHttp;
