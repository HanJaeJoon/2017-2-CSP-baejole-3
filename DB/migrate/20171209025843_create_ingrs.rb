class CreateIngrs < ActiveRecord::Migration[5.1]
  def change
    create_table :ingrs do |t|
      t.references :medicine, foreign_key: true
      t.string :name
      t.integer :qnt
      t.integer :max
      t.timestamps
    end
  end
end
