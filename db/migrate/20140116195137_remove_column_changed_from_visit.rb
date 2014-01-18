class RemoveColumnChangedFromVisit < ActiveRecord::Migration
  def change
    remove_column :visits, :changed
    add_column :visits, :has_been_changed, :boolean
  end
end
