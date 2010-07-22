
class JobController < ApplicationController
  
  def show
    @group_counts =  Job.find(
              :all,
              :select => '`group`, COUNT(`group`) AS number_of_jobs',
              :group  => '`group`'
          )
    
   /job.grupo=Grupo.find_or_create_by_nombre(elementoxmlgruponombre)/
  end
  
  def index
    @jobs = Job.build_from_xml()
  end
  
  def datasave
    @jobs = Job.build_from_xml()
    for job in @jobs do
      job.save
    end
  end
  
end

