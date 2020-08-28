# frozen_string_literal: true

module Resolvers
  class ArticleSearch < Resolvers::BaseSearchResolver
    type [Types::ArticleType], null: false

    class OrderEnum < Types::BaseEnum
      graphql_name 'ArticleOrder'

      value 'TEXT'
      value 'NAME'
      value 'TYPE'
      value 'RECENT'
    end

    scope { Article.all }

    option :id, type: types.String, with: :apply_id_filter
    option :search, type: types.String, with: :search_by_name_or_text
    option :type, type: types.String, with: :apply_type_filter
    option :order, type: OrderEnum, default: 'RECENT'

    def apply_id_filter(scope, value)
      scope.where(id: value)
    end

    def apply_type_filter(scope, value)
      scope.where(article_type: value)
    end

    def search_by_name_or_text(scope, value)
      escaped_value = escape_search_term(value).downcase
      scope.where('lower(name) LIKE ? OR LOWER(text) LIKE ?', escaped_value, escaped_value)
    end

    def apply_order_with_recent(scope)
      scope.order('id DESC')
    end

    [:name, :type, :text].each do |attribute|
      define_method :"apply_order_with_#{attribute}" do |scope|
        scope.order("#{attribute} ASC")
      end
    end
  end
end
