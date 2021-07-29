class Investment < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :amount, presence: true
  validates :crypto, presence: true
  validates :group_id, presence: true

  validates :amount, numericality: { greater_than: 0, less_than: 1_000_000 }
end
