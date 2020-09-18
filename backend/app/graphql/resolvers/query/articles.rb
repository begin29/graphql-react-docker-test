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

        if Article.attribute_names.include?(ordered_filed)
          scope = scope.order(ordered_filed => order_direction)
        elsif ordered_filed.include?('.')
          scope = order_by_relation(scope, order_direction, *ordered_filed.split('.'))
        end
        scope
      end

      private

      def self.order_by_relation(scope, order_direction, relation_name, field_name)
        return scope unless Article.reflect_on_all_associations.map(&:name).include?(relation_name.to_sym)
        if relation_name.humanize.constantize.attribute_names.include?(field_name)
          scope = scope.left_outer_joins(relation_name.to_sym).order("#{relation_name.pluralize}.#{field_name} #{order_direction}")
        end
        scope
      end
    end
  end
end
