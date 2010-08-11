class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
       
      add_column :jobs, :project, :string, :limit => 20 
      add_column :jobs, :process, :string, :limit => 20


    end
  end

  def self.down
    remove_column :jobs, :project
    remove_column :jobs, :process
  end
end
