
class JobController < ApplicationController
  
  def show
    @group_counts =  Job.all({
     :select => "jobs.group AS nombre, COUNT('group') AS contador",
     :group =>"jobs.group"})
    
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

