module Types
  class QueryType < Types::BaseObject
    field :articles, resolver: Resolvers::ArticleSearch
  end
end
