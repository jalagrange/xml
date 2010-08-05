class AddProyectIdToSequence < ActiveRecord::Migration
  def self.up
    add_column :sequences, :proyect_id, :integer
  end

  def self.down
    remove_column :sequences, :proyect_id
  end
end
