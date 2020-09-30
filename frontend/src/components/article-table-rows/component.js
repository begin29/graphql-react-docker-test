import React, { Fragment, useEffect } from 'react';

export default function ArticleTableRows({ articles }) {
  return articles.map(article => {
    return (
      <Fragment key={article.id}>
        <tr>
          <td>{article.name}</td>
          <td>{article.text}</td>
          <td>{storyName(article.story)}</td>
        </tr>
      </Fragment>
    )
  });
};

const storyName = (story) => {
  if (story) {
    return story.name;
  }
  else {
    return '-';
  }
}
