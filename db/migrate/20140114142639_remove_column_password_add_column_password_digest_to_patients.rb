class RemoveColumnPasswordAddColumnPasswordDigestToPatients < ActiveRecord::Migration
  def change
    remove_column :patients, :password
    add_column :patients, :password_digest, :string
  end
end
