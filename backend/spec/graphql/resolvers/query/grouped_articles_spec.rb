require 'rails_helper'
include Support::Helpers::ArticlesHelper

module Resolvers
  module Query
    RSpec.describe Articles, type: :request do
      describe '#resolve' do
        let!(:story) { create(:story, articles: [article]) }
        let(:article) { create(:article) }

        context 'gets articles' do
          it 'group by name' do
            new_article = create(:article, name: article.name)
            post '/graphql', params: { query: request_query(grouped_by: 'name') }

            expect(
              JSON.parse(response.body)['data']['groupedArticles']
            ).to match(
              [
                {
                  'fieldName' => 'name',
                  'fieldValue' => article.name,
                  'articles' => [
                    expected_article_response(article),
                    expected_article_response(new_article)
                  ]
                }
              ]
            )
          end

          it 'group by text with order by id desc' do
            new_article = create(:article, name: article.name)
            post '/graphql', params: { query: request_query(grouped_by: 'name', order_by: 'id desc') }

            expect(
              JSON.parse(response.body)['data']['groupedArticles']
            ).to match(
              [
                {
                  'fieldName' => 'name',
                  'fieldValue' => article.name,
                  'articles' => [
                    expected_article_response(new_article),
                    expected_article_response(article)
                  ]
                }
              ]
            )
          end

          it 'group by text with search by name' do
            new_articles = create_list(:article, 2, text: 'Unique TEXT')
            matched_article = new_articles.first
            matched_article.update(name: article.name)
            post '/graphql', params: { query: request_query(grouped_by: 'text', search: article.name) }

            expect(
              JSON.parse(response.body)['data']['groupedArticles']
            ).to match(
              [
                {
                  'fieldName' => 'text',
                  'fieldValue' => article.text,
                  'articles' => [
                    expected_article_response(article)
                  ]
                },
                {
                  'fieldName' => 'text',
                  'fieldValue' => matched_article.text,
                  'articles' => [
                    expected_article_response(matched_article)
                  ]
                }
              ]
            )
          end
        end

        def request_query(search: '', order_by: '', grouped_by: '')
          <<~GQL
            {
              groupedArticles(search: "#{search}", orderBy: "#{order_by}", groupedBy: "#{grouped_by}") {
                fieldName
                fieldValue
                articles {
                  id
                  name
                  text
                  story {
                    id
                    name
                  }
                }
              }
            }
          GQL
        end
      end
    end
  end
end
