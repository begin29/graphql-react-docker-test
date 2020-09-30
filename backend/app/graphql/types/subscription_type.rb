module Types
  class SubscriptionType < Types::BaseObject
    field :new_article, Types::Articles::ArticleType, null: false
  end
end
