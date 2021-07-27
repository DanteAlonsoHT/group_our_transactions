class Investment < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :groups

  validates :amount, presence: true
  validates :crypto, presence: true

  validates :amount, numericality: { greater_than: 0, less_than: 1000000 }
end
