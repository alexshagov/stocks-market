class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.references :bearer, null: false, foreign_key: true
      t.string :name, index: { unique: true }, null: false
      t.string :reference, index: { unique: true }, null: false

      t.timestamps
    end
  end
end
