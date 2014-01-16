class AddIndexToPatientsPesel < ActiveRecord::Migration
  def change
    remove_index :patients, :pesel
  end
end
