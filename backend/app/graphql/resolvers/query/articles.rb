module Resolvers
  module Query
    class Articles
      def self.resolve(**args)
        scope = articles_scope(args[:limit])
        scope = search_by(scope, args[:search]) if args[:search].present?

        scope = order_by(scope, args[:order_by]) if args[:order_by].present?
        scope
      end

      def self.articles_scope(limit = 100)
        Article.all.limit(limit)
      end

      def self.search_by(scope, search_text)
        escaped_value = "%#{search_text.gsub(/\s+/, '%')}%".downcase
        scope.where('name iLIKE ? OR text iLIKE ?', escaped_value, escaped_value)
      end

      def self.order_by(scope, ordered_filed)
        ordered_filed, order_direction = ordered_filed.split(' ')
        order_direction = order_direction.in?(%w[asc desc]) ? order_direction : :asc
        scope = scope.order(ordered_filed => order_direction) if Article.attribute_names.include?(ordered_filed)
        scope
      end
    end
  end
end
