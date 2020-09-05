module Resolvers
  module Query
    class GroupByStoryArticles
      def self.resolve(**args)
        scope = Resolvers::Query::Articles.resolve(args)

        scope.group_by(&:story_id).map do |story_id, articles|
          {
            articles_count: articles.size,
            story_id: story_id,
            articles_type_count: count_of_atricles_types(articles),
            last_article: articles[-1]
          }
        end
      end

      def self.count_of_atricles_types(articles)
        articles.group_by(&:article_type).map do |article_type, grouped_articles|
          {
            article_type: article_type,
            count: grouped_articles.size
          }
        end
      end
    end
  end
end
