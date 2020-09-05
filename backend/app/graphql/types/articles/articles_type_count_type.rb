module Types
  module Articles
    class ArticlesTypeCountType < Types::BaseObject
      field :article_type, String, null: false
      field :count, String, null: false
    end
  end
end
