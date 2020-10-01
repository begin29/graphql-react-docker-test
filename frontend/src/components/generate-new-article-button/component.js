import React, { Fragment } from 'react';
import { gql, useMutation } from '@apollo/client';
import faker from 'faker'

const CREATE_ARTICLE = gql`
  mutation createArticle($name: String!, $text: String!) {
    createArticle(name: $name, text: $text) {
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

function GenerateNewArticleButton() {
  const [createArticle, { data }] = useMutation(CREATE_ARTICLE);

  return (
    <Fragment>
      <button onClick={() =>
          {
            createArticle({ variables: { name: faker.lorem.word(), text: faker.lorem.sentence() } });
          }
        } >
        Generate Article
      </button>
    </Fragment>
  );
};

export { GenerateNewArticleButton as default, CREATE_ARTICLE };
