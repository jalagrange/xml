class CreateFormatos < ActiveRecord::Migration
  def self.up
    create_table :formatos do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :formatos
  end
end
