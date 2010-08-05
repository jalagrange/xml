class AddFormatotIdToSequence < ActiveRecord::Migration
  def self.up
    add_column :sequences, :formato_id, :integer
  end

  def self.down
    remove_column :sequences, :formato_id
  end
end
