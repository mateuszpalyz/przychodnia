class AddAgeSpecialtyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :specialty, :string
    add_column :users, :age, :integer
  end
end
