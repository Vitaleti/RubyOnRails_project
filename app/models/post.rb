class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2 }

  belongs_to :user

  has_one_attached :image
end