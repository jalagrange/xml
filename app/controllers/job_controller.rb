
class JobController < ApplicationController
  def show
    @jobs = Job.build_from_xml()
  end
end