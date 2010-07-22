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

ActiveRecord::Schema.define(:version => 20100722133536) do

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
    t.string   "ctime",          :limit => 50
    t.string   "qtime",          :limit => 50
    t.string   "etime",          :limit => 50
    t.string   "start",          :limit => 50
    t.string   "owner",          :limit => 50
    t.string   "session",        :limit => 50
    t.string   "end",            :limit => 50
    t.string   "exit_status",    :limit => 50
    t.string   "node_name",      :limit => 50
    t.string   "cpu",            :limit => 50
    t.time     "cput"
    t.string   "memory",         :limit => 50
    t.string   "virtual_memory", :limit => 50
    t.time     "walltime"
  end

end
