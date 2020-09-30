require 'rails_helper'

module Mutations
  describe CreateArticle do
    def perform(**args)
      Mutations::CreateArticle.new(object: nil, field: nil, context: {}).resolve(args)
    end

    it 'creates a new article' do
      link = perform(
        name: 'Article 1',
        text: 'description',
      )

      expect(link.persisted?).to be true
      expect(link.name).to eq('Article 1')
      expect(link.text).to eq('description')
      expect(link.article_type).to eq('facebook')
    end
  end
end
