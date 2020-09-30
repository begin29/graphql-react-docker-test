import React from 'react';
import { waitFor, render, act, fireEvent } from '@testing-library/react';
import { MockedProvider } from '@apollo/client/testing';
import '@testing-library/jest-dom'
import { GET_ARTICLES, ARTICLES_SUBSCRIPTION } from './graphql-queries';
import ArticlesTable from './component';

describe('ArticlesTable', () => {
  const articleData = (prevId, storyData = null) => {
    const currentId = `${prevId+1}`;
    let storyObj;

    if (storyData) {
      storyObj = storyData;
    }
    else {
      storyObj = { id: '1', name: 'Great Story' };
    }

    return {
      id: currentId,
      name: `Article ${currentId}`,
      text: `Lorem Ipsum ${currentId}`,
      story: storyObj
    }
  }

  const defaultArticlesMock = {
    request: {
      query: GET_ARTICLES,
      variables: { orderBy: 'name asc', search: '' },
    },
    result: {
      data: { articles: [articleData(0), articleData(1)] },
    },
  };

  const subscribeToNewArticleMock = {
    request: {
      query: ARTICLES_SUBSCRIPTION,
      variables: {},
    },
    result: {
      data: { newArticle: articleData(2) },
    },
  }

  it('renders articles table', async () => {
    const tableEl = render(
      <MockedProvider mocks={ [defaultArticlesMock, subscribeToNewArticleMock ] } addTypename={false}>
        <ArticlesTable search='' />
      </MockedProvider>
    );

    await new Promise(resolve => setTimeout(resolve, 0));

    const articleRowHtml = tableEl.container.querySelector('tbody tr').innerHTML;
    expect(articleRowHtml).toMatch('Lorem');
    expect(articleRowHtml).toMatch('Article 1');
    expect(articleRowHtml).toMatch('Great Story');
  });

  it('sorts articles by text desc', async () => {
    let sortedByTextArticlesMock = {
      request: {
        query: GET_ARTICLES,
        variables: { orderBy: 'text desc', search: '' },
      },
      result: {
        data: {
          articles: [articleData(1), articleData(0)]
        },
      },
    };

    const { container, getByText } = render(
      <MockedProvider mocks={ [defaultArticlesMock, sortedByTextArticlesMock, subscribeToNewArticleMock] } addTypename={false}>
        <ArticlesTable search='' />
      </MockedProvider>
    );

    await waitFor(() => {
      expect(getByText('Article 1')).toBeInTheDocument();
    })

    fireEvent(
      container.querySelectorAll('thead a')[1],
      new MouseEvent('click', { bubbles: true })
    );
    await waitFor(() => {
      expect(getByText('Article 2')).toBeInTheDocument();
    })
    const articleRows = container.querySelectorAll('tbody tr');
    expect(articleRows[0].innerHTML).toMatch('Article 2');
    expect(articleRows[1].innerHTML).toMatch('Article 1');
  });

  it('found articles by text', async () => {
    const searchedArticlesByNameMock = {
      request: {
        query: GET_ARTICLES,
        variables: { orderBy: 'name asc', search: 'article 1' },
      },
      result: {
        data: {
          articles: [articleData(0)]
        },
      },
    };

    const { container, getByText } = render(
      <MockedProvider mocks={ [searchedArticlesByNameMock, subscribeToNewArticleMock] } addTypename={false}>
        <ArticlesTable search='article 1' />
      </MockedProvider>
    );

    await waitFor(() => {
      expect(getByText('Article 1')).toBeInTheDocument();
    });

    const articleRows = container.querySelectorAll('tbody tr');

    expect(articleRows[0].innerHTML).toMatch('Article 1');
  });
});
