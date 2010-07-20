
class JobController < ApplicationController
  def show
    @jobs = Job.find_all()
  end
end