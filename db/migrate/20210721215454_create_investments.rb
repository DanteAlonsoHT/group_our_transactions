class CreateInvestments < ActiveRecord::Migration[6.1]
  def change
    create_table :investments do |t|
      t.integer :author_id, null: false
      t.string :crypto, null: false
      t.decimal :amount, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
