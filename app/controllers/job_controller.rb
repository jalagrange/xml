
class JobController < ApplicationController
  
  def show
    @group_counts =  Job.groups
    @time_in_queue = Job.time_in_queue
    @time_in_execution = Job.time_in_execution
    @memory = Job.memory * 1024
    @virtual_memory = Job.virtual_memory * 1024
    @cput = Job.cput
    @walltime = Job.walltime
     
      /job.grupo=Grupo.find_or_create_by_nombre(elementoxmlgruponombre)/
  end
  
  def index
    @jobs = Job.build_from_xml()
  end
  
  def datasave
    @jobs = Job.build_from_xml()
    for job in @jobs do
      /PRESENILE_fsproc_NMP_214.sh/
     @process = job.jobname.split('_')
      job.proyect = @process[0]
      job.process = @process[1]
      job.save
    end
    
  end
  
end

