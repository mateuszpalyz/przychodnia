class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :cause
      t.string :psymptom
      t.string :time_symptom
      t.string :illness_chage
      t.string :symptom_type
      t.string :time_illness
      t.string :freq_illness
      t.string :care
      t.string :dsymptom
      t.string :illness
      t.string :drugs
      t.datetime :next_visit
      t.boolean :changed
      t.integer :user_id
      t.integer :patient_id

      t.timestamps
    end
    add_index :visits, :patient_id
  end
end
