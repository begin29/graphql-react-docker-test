import React, { Fragment, useState } from 'react';

import Row from 'react-bootstrap/Row';
import SearchInput from './search-input/component';
import GroupBySelect from './group-by-select/component';
import GenerateNewArticleButton from './generate-new-article-button/component';

import ArticlesTable from './articles-table/component';
import GroupedArticlesTable from './grouped-articles-table/component';
import GroupedByStoryTable from './grouped-by-story-table/component';

export default function MainBody() {
  const [search, setSearch] = useState('');
  const [tableName, setTableName] = useState('Articles');
  const [groupByField, setGroupByField] = useState('name');

  const tableComponent = () => {
    switch (tableName) {
      case 'ArticlesGroupBy':
        return <GroupedArticlesTable search={search} groupByField={groupByField} />;
      case 'GroupedByStory':
        return <GroupedByStoryTable search={search} />;
      default:
        return <ArticlesTable search={search} />;
    }
  }

  return (
    <Fragment>
      <Row>
        <SearchInput setSearch={setSearch} />
        <GroupBySelect setTableName={setTableName} setGroupByField={setGroupByField} />
      </Row>
      <Row>
        {tableComponent()}
      </Row>
      <Row>
        <GenerateNewArticleButton />
      </Row>
    </Fragment>
  )
};
