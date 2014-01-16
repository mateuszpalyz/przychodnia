class AddIndexToPatientsPesel2 < ActiveRecord::Migration
  def change
    add_index :patients, :pesel, unique: true
  end
end
