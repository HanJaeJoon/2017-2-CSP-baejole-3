class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :pregnant
      t.boolean :feeding

      t.timestamps
    end
  end
end
