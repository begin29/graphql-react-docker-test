import React, { Fragment, useState } from 'react';
import ReactDOM from 'react-dom';

export default function SearchInput({ setSearch }) {
  const [searchValue, setSearchValue] = useState('');

  return (
    <Fragment>
      <input
        name='search'
        type='text'
        value={searchValue}
        onChange={event => setSearchValue(event.target.value)}
      />
      <button type="button" onClick={() => setSearch(searchValue)}>
        Search
      </button>
    </Fragment>
  );
};
