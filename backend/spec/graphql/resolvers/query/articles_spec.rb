require 'rails_helper'
include Support::Helpers::ArticlesHelper

module Resolvers
  module Query
    RSpec.describe Articles, type: :request do
      describe '#resolve' do
        let!(:story) { create(:story, articles: [article]) }
        let(:article) { create(:article) }

        it 'gets list of articles with stories' do
          post '/graphql', params: { query: request_query }
          returned_article = article_by_id_from(response.body, article.id)

          expect(returned_article).to match(
            expected_article_response(article)
          )
        end

        context 'search articles' do
          shared_examples 'by field name' do
            it 'gets articles by field' do
              post '/graphql', params: { query: request_query(search: 'ABC') }
              returned_article = article_by_id_from(response.body, article_record.id)

              expect(returned_article).to match(
                expected_article_response(article)
              )
            end
          end

          include_examples 'by field name' do
            let!(:article_record) { article.update(name: 'ABC'); article; }
          end

          include_examples 'by field name' do
            let!(:article_record) { article.update(text: 'ABC'); article }
          end
        end

        context 'order articles' do
          it 'by id desc' do
            new_article = create(:article)
            post '/graphql', params: { query: request_query(order_by: 'id desc') }

            expect(
              JSON.parse(response.body)['data']['articles']
            ).to match(
              [
                expected_article_response(new_article),
                expected_article_response(article)
              ]
            )
          end

          it 'by name desc' do
            article.update(name: 'AAA')
            new_article = create(:article, name: 'ZZZ')
            post '/graphql', params: { query: request_query(order_by: 'name desc') }

            expect(
              JSON.parse(response.body)['data']['articles']
            ).to match(
              [
                expected_article_response(new_article),
                expected_article_response(article)
              ]
            )
          end

          it 'by text asc' do
            article.update(text: 'AAA')
            new_article = create(:article, text: 'ZZZ')
            post '/graphql', params: { query: request_query(order_by: 'text asc') }

            expect(
              JSON.parse(response.body)['data']['articles']
            ).to match(
              [
                expected_article_response(article),
                expected_article_response(new_article)
              ]
            )
          end

          it 'by unknown field returns order by created time in asc order' do
            new_article = create(:article)
            post '/graphql', params: { query: request_query(order_by: 'text asc') }

            expect(
              JSON.parse(response.body)['data']['articles']
            ).to match(
              [
                expected_article_response(article),
                expected_article_response(new_article)
              ]
            )
          end
        end

        def article_by_id_from(response, id)
          data = JSON.parse(response)['data']['articles']
          data.detect { |rec| rec['id'].to_i == id }
        end

        def request_query(search: '', order_by: '')
          <<~GQL
            {
              articles(search: "#{search}", orderBy: "#{order_by}") {
                id
                name
                text
                story {
                  id
                  name
                }
              }
            }
          GQL
        end
      end
    end
  end
end
