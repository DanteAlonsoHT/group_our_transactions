class Group < ApplicationRecord
  belongs_to :user

  has_many :investments

  has_one :image
end
