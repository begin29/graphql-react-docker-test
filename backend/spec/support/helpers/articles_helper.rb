module Support
  module Helpers
    module ArticlesHelper
      def expected_article_response(article_record)
        story_record = article_record.story
        article_hash = {
          'id' => article_record.id.to_s,
          'name' => article_record.name,
          'text' => article_record.text,
          'story' => nil
        }
        if story_record
          article_hash['story'] = {
            'id' => story_record.id.to_s,
            'name' => story_record.name
          }
        end
        article_hash
      end
    end
  end
end
