import { gql } from '@apollo/client';

const ARTICLES_SUBSCRIPTION = gql`
  subscription OnNewArticle {
    newArticle {
      id
      name
      text
      story {
        id
        name
      }
    }
  }
`;

const GET_ARTICLES = gql`
  query articles($orderBy: String!, $search: String!) {
    articles(search: $search, orderBy: $orderBy) {
      id
      name
      text
      story {
        id
        name
      }
    }
  }
`;

export { GET_ARTICLES, ARTICLES_SUBSCRIPTION };
