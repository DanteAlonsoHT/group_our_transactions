class User < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    has_many :investments
    has_many :groups
end
