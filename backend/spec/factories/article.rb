FactoryBot.define do
  factory :article do
    sequence(:name) { |n| "Article #{n}" }
    text  { "Lorem Ipsum" }
    article_type { 'blog' }

    trait :facebook_post do
      article_type { 'facebook' }
    end

    trait :tweet do
      article_type { 'tweeter' }
    end

    after(:build) do |article|
      article.story = build(:story, articles: [article])
    end
  end
end
