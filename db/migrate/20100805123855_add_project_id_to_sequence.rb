class AddProjectIdToSequence < ActiveRecord::Migration
  def self.up
    add_column :sequences, :project_id, :integer
  end

  def self.down
    remove_column :sequences, :project_id
  end
end
