# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100726140033) do

  create_table "jobs", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "jobid",          :limit => 50
    t.string   "day",            :limit => 50
    t.time     "time"
    t.string   "user",           :limit => 50
    t.string   "group",          :limit => 50
    t.string   "jobname",        :limit => 50
    t.string   "queue",          :limit => 50
    t.integer  "ctime"
    t.integer  "qtime"
    t.integer  "etime"
    t.integer  "start"
    t.string   "owner",          :limit => 50
    t.string   "session",        :limit => 50
    t.integer  "end"
    t.string   "exit_status",    :limit => 50
    t.string   "node_name",      :limit => 50
    t.string   "cpu",            :limit => 50
    t.string   "cput",           :limit => 15
    t.integer  "memory"
    t.integer  "virtual_memory"
    t.string   "walltime",       :limit => 15
    t.string   "proyect",        :limit => 10
    t.integer  "process"
  end

  create_table "procesos", :force => true do |t|
    t.string   "name"
    t.integer  "software_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "processes", :force => true do |t|
    t.string   "name"
    t.integer  "software_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "softwares", :force => true do |t|
    t.string   "name",       :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
