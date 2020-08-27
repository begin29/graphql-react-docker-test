class Story < ApplicationRecord
  has_many :articles

  validates :name, presence: true, length: { minimum: 2, maximum: 255 }
  validates :articles, length: { minimum: 1 }
end
