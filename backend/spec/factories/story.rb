FactoryBot.define do
  factory :story do
    sequence(:name) { |n| "Story #{n}" }
  end
end
