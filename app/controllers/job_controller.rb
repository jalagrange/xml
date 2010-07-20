
class JobController < ApplicationController
  def show
    @jobs = Job.build_from_xml()
  end
  
  def datasave
    @jobs = Job.build_from_xml()
    for job in @jobs do
      job.save
    end
  end
  
end