
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
      job.walltime = total_seconds(job.walltime)
      job.cput = total_seconds(job.cput)
      job.save
    end
  end
  
  def total_seconds (time)
    h,m,s= time.split(':')
    total_time = h.to_i * 3600 + m.to_i * 60 + s.to_i
    total_time
  end
  
end

