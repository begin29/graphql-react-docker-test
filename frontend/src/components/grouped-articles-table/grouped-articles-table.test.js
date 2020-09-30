import React from 'react';
import { waitFor, render, act, fireEvent } from '@testing-library/react';
import { MockedProvider } from '@apollo/client/testing';
import '@testing-library/jest-dom'
import GroupedArticlesTable, { GET_GROUPED_ARTICLES } from './component';

describe('GroupedArticlesTable', () => {
  const groupedByTextMock = {
    request: {
      query: GET_GROUPED_ARTICLES,
      variables: { groupedBy: 'text', search: '', orderBy: '' },
    },
    result: {
      data: { groupedArticles: [
        {
          fieldName: 'text',
          fieldValue: 'Lorem Ipsum',
          articles: 'Article 1, Article 2'
        }
      ]},
    },
  };

  it('groups articles by text', async() => {
    // NOTICE: do similar as within articles tables
  });
});
;
