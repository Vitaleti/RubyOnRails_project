class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2 }

  belongs_to :user

  has_one_attached :image

  has_many :likes, dependent: :destroy
  has_many :liked_by_users, through: :likes, source: :user

  has_many :comments, dependent: :destroy

  def liked_by?(user)
    likes.exists?(user: user)
  end
end