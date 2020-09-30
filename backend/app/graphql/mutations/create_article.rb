module Mutations
  class CreateArticle < BaseMutation
    argument :name, String, required: true
    argument :text, String, required: true

    type Types::Articles::ArticleType

    def resolve(name: nil, text: nil)
      Article.create!(
        name: name,
        text: text,
        article_type: 'facebook'
      )
    end
  end
end
