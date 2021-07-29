class RemoveFieldAuthorIdFromInvestments < ActiveRecord::Migration[6.1]
  def change
    remove_column :investments, :author_id, :integer
  end
end
