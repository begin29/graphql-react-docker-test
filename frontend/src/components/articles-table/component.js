import React, { Fragment, useState, useEffect } from 'react';
import Table from 'react-bootstrap/Table';
import ArticleTableRows from 'components/article-table-rows/component';
import { useQuery } from '@apollo/client';
import { GET_ARTICLES, ARTICLES_SUBSCRIPTION } from './graphql-queries'
import { apolloClient } from '../../index';
import './style.css';

function ArticlesTable({ search }) {
  const [articlesData, setArticlesData] = useState([]);
  const [sortConfig, setSortConfig] = useState({
    sortBy: 'name',
    sortDirection: 'asc'
  });

  const { subscribeToMore, loading, error, data } = useQuery(GET_ARTICLES,
    { variables:
      {
        orderBy: `${sortConfig.sortBy} ${sortConfig.sortDirection}`,
        search: search
      }
    });

  const subscribeToNewArticles = () => {
    subscribeToMore({
      document: ARTICLES_SUBSCRIPTION,
      updateQuery: (prev, { subscriptionData }) => {
        if (!subscriptionData.data) {
          return prev;
        };
        const newFeedItem = subscriptionData.data.newArticle;
        return Object.assign({}, prev, {
          articles: [...prev.articles, newFeedItem]
        });
      }
    });
  }

  useEffect(() => {
    if(!loading && data){
      setArticlesData(data.articles);
    }
  }, [loading, data]);

  useEffect(() => {
    subscribeToNewArticles();
  }, []);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error :(</p>;

  return (
    <Fragment>
      <Table>
        <thead>
          <tr>
            <th>
              <a onClick={() => {
                setSortConfig({ sortBy: 'name', sortDirection: sortDirection(sortConfig.sortDirection) });
                apolloClient.resetStore();
              }} >
                Name
              </a>
            </th>
            <th>
              <a onClick={() => {
                setSortConfig({ sortBy: 'text', sortDirection: sortDirection(sortConfig.sortDirection) });
                apolloClient.resetStore();
                }} >
                Text
              </a>
            </th>
            <th>
              <a onClick={() => {
                setSortConfig({ sortBy: 'story.name', sortDirection: sortDirection(sortConfig.sortDirection) });
                apolloClient.resetStore();
              }} >
                Story Name
              </a>
            </th>
          </tr>
        </thead>
        <tbody>
          <ArticleTableRows articles={articlesData} />
        </tbody>
      </Table>
    </Fragment>
  );
};

const sortDirection = (currentDirection) => {
  if (currentDirection == 'asc') {
    return 'desc';
  } else {
    return 'asc';
  }
}

export { ArticlesTable as default, GET_ARTICLES };
