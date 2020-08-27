class Article < ApplicationRecord
  belongs_to :story

  validates :name, presence: true, length: { minimum: 2 }
  validates_presence_of :story_id
  validates_inclusion_of :article_type, in: %w(blog facebook tweeter)
end
