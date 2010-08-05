class Proyect < ActiveRecord::Base
 has_many :jobs
 has_many :sequences
end
