class CreateBearers < ActiveRecord::Migration[6.0]
  def change
    create_table :bearers do |t|
      t.string :name, index: { unique: true }, null: false
      t.string :reference, index: { unique: true }, null: false

      t.timestamps
    end
  end
end
