class CreateProcesos < ActiveRecord::Migration
  def self.up
    create_table :procesos do |t|
      t.string :name
      t.integer :software_id

      t.timestamps
    end
  end

  def self.down
    drop_table :procesos
  end
end
