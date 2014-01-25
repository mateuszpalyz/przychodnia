class ChangingColumsInVisits < ActiveRecord::Migration
  def self.up
    rename_column :visits, :next_visit, :date_entered_string
    add_column :visits, :next_visit, :datetime
    remove_column :visits, :date_entered_string
  end
end
