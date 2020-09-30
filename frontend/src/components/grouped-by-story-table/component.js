import React, { Fragment, useState, useEffect } from 'react';
import Table from 'react-bootstrap/Table';

import { useQuery, gql } from '@apollo/client';

const GROUPED_BY_STORY_ARTICLES = gql`
  query groupByStoryArticles($search: String!) {
    groupByStoryArticles(search: $search) {
      storyId,
      articlesCount,
      articlesTypeCount {
        articleType
        count
      },
      lastArticle {
        id
        name
        text
      }
    }
	}
`;

export default function GroupedByStoryTable({ search }) {
  const [articlesData, setArticlesData] = useState([]);
  const { loading, error, data } = useQuery(GROUPED_BY_STORY_ARTICLES,
    { variables:
      {
        search
      }
    });

  useEffect(() => {
    if(!loading && data){
      setArticlesData(data.groupByStoryArticles);
    }
  }, [loading, data]);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error :(</p>;

  return (
    <Fragment>
      <Table>
        <thead>
          <tr>
            <th>Story ID</th>
            <th>Articles Count</th>
            <th>Articles Type Count</th>
            <th>Last Article</th>
          </tr>
        </thead>
        <tbody>
          {articlesData.map(item => (
            <tr>
              <td>{ item.storyId || '-' }</td>
              <td>{ item.articlesCount }</td>
              <td>{ typesCount(item.articlesTypeCount) }</td>
              <td>{ item.lastArticle.name }</td>
            </tr>
          ))}
        </tbody>
      </Table>
    </Fragment>
  );
};

const typesCount = (articlesTypesCountData) => {
  return articlesTypesCountData.map( item => {
    return `${item.articleType}: ${item.count}`;
  }).join(', ');
};
