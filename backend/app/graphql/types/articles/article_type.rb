module Types
  module Articles
    class ArticleType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: true
      field :text, String, null: true
      field :article_type, String, null: true
      field :story_id, Integer, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :story, Types::StoryType, null: true
    end
  end
end
