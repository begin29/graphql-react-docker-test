import React, { Fragment, useState, useEffect } from 'react';
import ReactDOM from 'react-dom';

export default function GroupBySelect({setTableName, setGroupByField}) {
  const handleChange = (e) => {
    if (e.target && e.target.value) {
      if (e.target.value === 'storyId') {
        setTableName('GroupedByStory');
      } else {
        setTableName('ArticlesGroupBy');
        setGroupByField(e.target.value);
      }
    } else {
      setTableName('Articles');
    }
  }

  return (
    <Fragment>
      <select onChange={(e) => handleChange(e)}>
        <option value="">Clear Group</option>
        <optgroup label="Group By Article fields">
          <option value="id">ID</option>
          <option value="name">Name</option>
          <option value="text">Text</option>
        </optgroup>
        <option value="storyId">Group By Story</option>
      </select>
    </Fragment>
  );
};
