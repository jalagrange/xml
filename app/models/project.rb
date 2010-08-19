class Project < ActiveRecord::Base
 has_many :jobs
 has_many :sequences
 has_many :process_spaces
end
