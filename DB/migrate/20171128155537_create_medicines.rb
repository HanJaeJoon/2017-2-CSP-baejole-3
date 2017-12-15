class CreateMedicines < ActiveRecord::Migration[5.1]
  def change
    create_table :medicines do |t|
      t.string :title
      t.integer :code
      t.date :ps_date
      t.date :expir_date
      t.integer :quantity
      t.string :take_time
      t.boolean :is_take
      t.boolean :is_keep
      t.boolean :is_alarm
      t.integer :status
      t.references :user, foreign_key: true
      t.references :prescription, foreign_key: true

      t.timestamps
    end
  end
end
