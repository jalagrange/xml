
class JobsController < ApplicationController
  
  def show
   @jobs = Job.all
     
      /job.grupo=Grupo.find_or_create_by_nombre(elementoxmlgruponombre)/
  end
  
  def index
      @group_counts =  Job.groups
      @time_in_queue = Job.time_in_queue
      @time_in_execution = Job.time_in_execution
      @memory = Job.memory * 1024
      @virtual_memory = Job.virtual_memory * 1024
      @cput = Job.cput
      @walltime = Job.walltime
  end
  
  def datasave
    @jobs = Job.build_from_xml()
    for job in @jobs do
      /PRESENILE_fsproc_NMP_214.sh/
     @split = job.jobname.split('_')
      job.proyect = @split[0]
      job.proceso = Proceso.find_by_name(@split[1])
      job.walltime = total_seconds(job.walltime)
      job.cput = total_seconds(job.cput)
      job.save
    end
     respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @jobs }
      end
  end
  
  def charts
      @group_counts =  Job.process
      @time_in_queue = Job.time_in_queue
      @time_in_execution = Job.time_in_execution
      @memory = Job.memory * 1024
      @virtual_memory = Job.virtual_memory * 1024
      @cput = Job.cput
      @walltime = Job.walltime
  end
  
  def total_seconds (time)
    h,m,s= time.split(':')
    total_time = h.to_i * 3600 + m.to_i * 60 + s.to_i
    total_time
  end
  
end

