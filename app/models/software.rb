class Software < ActiveRecord::Base
  has_many :procesos
  has_many :jobs, :through => :procesos
end
