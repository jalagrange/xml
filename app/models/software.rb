class Software < ActiveRecord::Base
  has_many :procesos
  has_many :jobs, :through => :procesos
  has_many :process_spaces
  
  SeriesData = Struct.new(:name, :data)
end
