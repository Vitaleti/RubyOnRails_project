class User < ApplicationRecord
  validates :name, presence: true
  validates :lastname, presence: true
  validates :nickname, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_]+\z/, message: "can only contain letters, numbers, and underscores" }
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0 }


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts
end
