class CreateDiseases < ActiveRecord::Migration[5.1]
  def change
    create_table :diseases do |t|
      t.string :title
      t.string :part
      t.text :desc

      t.timestamps
    end
  end
end
