class User < ApplicationRecord
  # Подписчики, которые подписаны на этого пользователя
  has_many :active_subscriptions, class_name: "Subscription", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_subscriptions, source: :followed

  # Пользователи, на которых подписан этот пользователь
  has_many :passive_subscriptions, class_name: "Subscription", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_subscriptions, source: :follower

  # Проверки полей при регистрации
  validates :name, presence: true
  validates :lastname, presence: true
  validates :nickname, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_]+\z/, message: "can only contain letters, numbers, and underscores" }
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Ассоциация для постов
  has_many :posts

  # Подключение Active Storage для аватара
  has_one_attached :avatar

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  def follow(other_user)
    active_subscriptions.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_subscriptions.find_by(followed_id: other_user.id).destroy
  end
end
