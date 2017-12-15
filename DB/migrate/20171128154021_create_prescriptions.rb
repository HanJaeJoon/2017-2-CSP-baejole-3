class CreatePrescriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :prescriptions do |t|
      t.string :title
      t.string :hs_name
      t.string :ds_name
      t.date :ps_date
      t.integer :cnt
      t.string :st_time
      t.boolean :is_alarm
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
