class Investment < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :groups

  validates :amount, presence: true
  validates :crypto, presence: true
end
