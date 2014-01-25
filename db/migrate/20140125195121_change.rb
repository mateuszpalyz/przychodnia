class Change < ActiveRecord::Migration
  def change
    remove_column :visits, :next_visit
    add_column :visits, :next_visit, :datetime
  end
end
