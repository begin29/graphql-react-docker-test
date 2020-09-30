import React, { Fragment, useState, useEffect } from 'react';
import Table from 'react-bootstrap/Table';
import { useQuery, gql } from '@apollo/client';

const GET_GROUPED_ARTICLES = gql`
  query groupedArticles($groupedBy: String!, $orderBy: String!, $search: String!) {
    groupedArticles(groupedBy: $groupedBy, search: $search, orderBy: $orderBy) {
      fieldName
      fieldValue
      articles {
        id
        name
        text
      }
    }
  }
`;

function GroupedArticlesTable({ search, groupByField }) {
  const [articlesData, setArticlesData] = useState([]);
  const orderBy = '';

  const { loading, error, data } = useQuery(GET_GROUPED_ARTICLES,
    { variables:
      {
        groupedBy: groupByField,
        search,
        orderBy
      }
    });

  useEffect(() => {
    if(!loading && data){
      setArticlesData(data.groupedArticles);
    }
  }, [loading, data]);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error :(</p>;

  return (
    <Fragment>
      <Table>
        <thead>
          <tr>
            <th>Field Name</th>
            <th>Field Value</th>
            <th>Articles</th>
          </tr>
        </thead>
        <tbody>
          {articlesData.map(item => (
            <tr>
              <td>{ item.fieldName }</td>
              <td>{ item.fieldValue }</td>
              <td>{ item.articles.map(article => ( article.name )).join(', ') }</td>
            </tr>
          ))}
        </tbody>
      </Table>
    </Fragment>
  )
};

export { GroupedArticlesTable as default, GET_GROUPED_ARTICLES };
