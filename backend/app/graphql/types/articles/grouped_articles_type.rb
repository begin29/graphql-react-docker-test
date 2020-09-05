module Types
  module Articles
    class GroupedArticlesType < Types::BaseObject
      field :field_name, String, null: false
      field :field_value, String, null: true
      field :articles, [Types::Articles::ArticleType], null: false
    end
  end
end
