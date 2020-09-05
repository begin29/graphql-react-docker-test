class Article < ApplicationRecord
  belongs_to :story, optional: true

  validates :name, presence: true, length: { minimum: 2, maximum: 255 }
  validates_inclusion_of :article_type, in: %w[blog facebook tweeter]
end
