class CreateProcessSpaces < ActiveRecord::Migration
  def self.up
    create_table :process_spaces do |t|
      t.string :name
      t.integer :size

      t.timestamps
    end
  end

  def self.down
    drop_table :process_spaces
  end
end
