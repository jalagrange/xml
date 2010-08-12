class ChartsController < ApplicationController

  def index
     
     @chart = Chart.new
     
       respond_to do |format|
         format.html # index.html.erb
         format.xml  { render :xml => @procesos }
       end
  end

  def show

    @chart = Chart.new(params[:chart])
    if  !(params[:software_ids].nil?)
      @softwares = Software.find(params[:software_ids])
    end
    if  !(params[:project_ids].nil?)
      @projects = Project.find(params[:project_ids]) 
    end 
    @resources = Resource.find(params[:resource_ids])
    @data = []

    if  !(params[:software_ids].nil? || params[:project_ids].nil?)
      process_chart_with_all_variables(@softwares, @projects, @resources)
    end

    if  (params[:software_ids].nil? && !(params[:project_ids].nil?) )
      process_chart_with_projects_only(@projects, @resources)
    end

    if  (params[:project_ids].nil? && !(params[:softwares_ids].nil?))
      process_chart_with_softwares_only(@softwares, @resources)
    end
    
    if  (params[:project_ids].nil? && params[:software_ids].nil?)
      process_chart_with_resources_only(@resources)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @formato }
    end
  end

  def process_chart_with_all_variables(softwares, projects, resources)

    softwares.each do |software|
      procesos = software.procesos
      @jobs = software.jobs
      projects.each do |project|
        @resources.each do |resource|
          data1 = {}

          data1[:name] = "#{resource.name} #{software.name} #{project.name}"
          data1[:data] = @jobs.find(
          :all,
          :select => "day, SUM(#{resource.name}) as data_attribute",
          :conditions => "project_id = '#{project.id}'",
          :group => "day")
          if  !(data1[:data].nil? || data1[:data].empty?)
            @data << data1
          end
        end
      end
    end
    return @data
  end
  
  def process_chart_with_projects_only(projects, resources)
    projects.each do |project|
       @jobs = project.jobs
       resources.each do |resource|
         data1 = {}

         data1[:name] = "#{resource.name} #{project.name}"
         data1[:data] = @jobs.find(
         :all,
         :select => "day, SUM(#{resource.name}) as data_attribute",
         :group => "day")
         if  !(data1[:data].nil? || data1[:data].empty?)
           @data << data1
         end
       end
     end
     return @data 
  end

  def process_chart_with_softwares_only(softwares, resources)
    softwares.each do |software|
      procesos = software.procesos
      @jobs = software.jobs

      @resources.each do |resource|
        data1 = {}

        data1[:name] = "#{resource.name} #{software.name}"
        data1[:data] = @jobs.find(
        :all,
        :select => "day, SUM(#{resource.name}) as data_attribute",
        :group => "day")
        if  !(data1[:data].nil? || data1[:data].empty?)
          @data << data1
        end
      end
    end
    return @data 
  end
  
  def process_chart_with_resources_only(resources)
      resources.each do |resource|
        data1 = {}
        data1[:name] = "#{resource.name}"
        data1[:data] = Job.find(
        :all,
        :select => "day, SUM(#{resource.name}) as data_attribute",
        :group => "day")
        if  !(data1[:data].nil? || data1[:data].empty?)
          @data << data1
        end
      end
    return @data 
  end

end
