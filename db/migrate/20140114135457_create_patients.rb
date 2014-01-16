class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :name
      t.string :surname
      t.string :pesel

      t.timestamps
    end
    add_index :patients, :pesel
  end
end
