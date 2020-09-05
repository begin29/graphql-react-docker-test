module Types
  module Articles
    class GroupByStoryType < Types::BaseObject
      field :story_id, String, null: true
      field :articles_count, String, null: false
      field :articles_type_count, [Types::Articles::ArticlesTypeCountType], null: false
      field :last_article, Types::Articles::ArticleType, null: false
    end
  end
end
