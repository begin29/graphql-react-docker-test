module Types
  class QueryType < Types::BaseObject
    field :articles, [Types::Articles::ArticleType], null: false do
      argument :search, String, required: false
      argument :order_by, String, required: false
    end

    field :grouped_articles, [Types::Articles::GroupedArticlesType], null: false do
      argument :grouped_by, String, required: true
      argument :search, String, required: false
      argument :order_by, String, required: false
    end

    field :group_by_story_articles, [Types::Articles::GroupByStoryType], null: false do
      argument :search, String, required: false
      argument :order_by, String, required: false
    end

    def articles(**args)
      Resolvers::Query::Articles.resolve(args)
    end

    def group_by_story_articles(**args)
      Resolvers::Query::GroupByStoryArticles.resolve(args)
    end

    def grouped_articles(**args)
      Resolvers::Query::GroupedArticles.resolve(args)
    end
  end
end
