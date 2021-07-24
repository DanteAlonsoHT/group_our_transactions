class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :investments
  has_many :groups

  validates :name, presence: true, length: { minimum: 4, maximum: 32 }

  has_one_attached :avatar
end
