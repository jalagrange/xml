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

ActiveRecord::Schema.define(:version => 20100811094330) do

  create_table "charts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formatos", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "jobid",          :limit => 50
    t.date     "day"
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
    t.integer  "project_id"
    t.integer  "proceso_id"
  end

  create_table "procesos", :force => true do |t|
    t.string   "name"
    t.integer  "software_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sequences", :force => true do |t|
    t.string   "name"
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "proyect_id"
    t.integer  "formato_id"
  end

  create_table "softwares", :force => true do |t|
    t.string   "name",       :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
