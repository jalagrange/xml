class Job < ActiveRecord::Migration
  def self.up
    add_column :jobs, :jobid, :string, :limit => 50 
    add_column :jobs, :day, :string, :limit => 50 
    add_column :jobs, :time, :time
    add_column :jobs, :user, :string, :limit => 50 
    add_column :jobs, :group, :string, :limit => 50 
    add_column :jobs, :jobname, :string, :limit => 50 
    add_column :jobs, :queue, :string, :limit => 50 
    add_column :jobs, :ctime, :string, :limit => 50 
    add_column :jobs, :qtime, :string, :limit => 50 
    add_column :jobs, :etime, :string, :limit => 50 
    add_column :jobs, :start, :string, :limit => 50 
    add_column :jobs, :owner, :string, :limit => 50 
    add_column :jobs, :session, :string, :limit => 50 
    add_column :jobs, :end, :string, :limit => 50 
    add_column :jobs, :exit_status, :string, :limit => 50 
    add_column :jobs, :node_name, :string, :limit => 50 
    add_column :jobs, :cpu, :string, :limit => 50 
    add_column :jobs, :cput, :time
    add_column :jobs, :memory, :string, :limit => 50 
    add_column :jobs, :virtual_memory, :string, :limit => 50 
    add_column :jobs, :walltime, :time
  end

  def self.down
    remove_column :jobs, :jobid
    remove_column :jobs, :day
    remove_column :jobs, :time
    remove_column :jobs, :user
    remove_column :jobs, :group
    remove_column :jobs, :jobname
    remove_column :jobs, :queue
    remove_column :jobs, :ctime
    remove_column :jobs, :qtime
    remove_column :jobs, :etime
    remove_column :jobs, :start
    remove_column :jobs, :owner
    remove_column :jobs, :session
    remove_column :jobs, :end
    remove_column :jobs, :exit_status
    remove_column :jobs, :node_name
    remove_column :jobs, :cpu
    remove_column :jobs, :cput
    remove_column :jobs, :memory
    remove_column :jobs, :virtual_memory
    remove_column :jobs, :walltime
  end
end
