class Software < ActiveRecord::Base
  has_many :procesos
  has_many :jobs, :through => :procesos
  
  SeriesData = Struct.new(:name, :data)
end
