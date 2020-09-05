module Resolvers
  module Query
    class GroupedArticles
      def self.resolve(**args)
        scope = Resolvers::Query::Articles.resolve(args)

        field_name = args[:grouped_by]
        if Article.attribute_names.include?(field_name)
          scope.group_by { |article| article.public_send(field_name) }.map do |field_value, articles|
            {
              field_name: field_name,
              field_value: field_value,
              articles: articles
            }
          end
        end
      end
    end
  end
end
