class Proceso < ActiveRecord::Base
  belongs_to :software
  has_many :jobs
end
