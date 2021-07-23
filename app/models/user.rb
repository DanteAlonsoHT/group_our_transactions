class User < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    has_many :investments
    has_many :groups

    has_one_attached :avatar
end
