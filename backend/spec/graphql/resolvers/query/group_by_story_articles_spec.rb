require 'rails_helper'
include Support::Helpers::ArticlesHelper

module Resolvers
  module Query
    RSpec.describe GroupByStoryArticles, type: :request do
      describe '#resolve' do
        let!(:story) { create(:story, articles: [article, *new_articles]) }
        let(:article) { create(:article) }
        let(:new_articles) { create_list(:article, 2, :facebook_post) }
        let(:last_article) { new_articles.last }

        it 'gets grouped by story totals' do
          post '/graphql', params: { query: request_query }

          expect(
            JSON.parse(response.body)['data']['groupByStoryArticles']
          ).to match(
            [
              {
                'articlesCount' => '3',
                'storyId' => story.id.to_s,
                'articlesTypeCount' => [
                  {
                    'articletype' => article.article_type,
                    'count' => '1'
                  },
                  {
                    'articleType' => 'facebook',
                    'count' => '2'
                  }
                ],
                'lastArticle' => expected_article_response(last_article)
              }
            ]
          )
        end

        context 'search by name or text' do
          it 'gets grouped by story totals' do
            new_articles.each { |article| article.update(text: 'Lorem abc XYZ') }
            post '/graphql', params: { query: request_query(search: 'ABC') }

            expect(
              JSON.parse(response.body)['data']['groupByStoryArticles']
            ).to match(
              [
                {
                  'articlesCount' => '2',
                  'storyId' => story.id.to_s,
                  'articlesTypeCount' => [
                    {
                      'articleType' => 'facebook',
                      'count' => '2'
                    }
                  ],
                  'lastArticle' => expected_article_response(last_article)
                }
              ]
            )
          end
        end

        context 'order by created time desc' do
          it 'gets grouped by story totals' do
            post '/graphql', params: { query: request_query(order_by: 'created_at desc') }

            expect(
              JSON.parse(response.body)['data']['groupByStoryArticles']
            ).to match(
              [
                {
                  'articlesCount' => '3',
                  'storyId' => story.id.to_s,
                  'articlesTypeCount' => [
                    {
                      'articleType' => 'facebook',
                      'count' => '2'
                    },
                    {
                      'articleType' => article.article_type,
                      'count' => '1'
                    }
                  ],
                  'lastArticle' => expected_article_response(article)
                }
              ]
            )
          end
        end

        def request_query(search: '', order_by: '')
          <<~GQL
            {
              groupByStoryArticles(search: "#{search}", orderBy: "#{order_by}") {
                articlesCount
                storyId
                articlesTypeCount {
                  articleType
                  count
                }
                lastArticle {
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
