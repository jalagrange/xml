class ChartsController < ApplicationController
  # GET /charts
  # GET /charts.xml
  def index

    @chart = Chart.new
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @charts }
    end
  end

  # GET /charts/1
  # GET /charts/1.xml
  def show
    #raise params.to_yaml
    @chart = Chart.new(params[:chart])
    @data = []
    @type = params[:type]
    @from = @chart.from
    @to = @chart.to
    respond_to do |format|
      if @chart.valid?

        if @type == "line"

          if  !(params[:resource_ids].nil?)
            @resources = Resource.find(params[:resource_ids])
          end

          if  !(params[:software_ids].nil?)
            @softwares = Software.find(params[:software_ids])
          end
          if  !(params[:project_ids].nil?)
            @projects = Project.find(params[:project_ids]) 
          end

          if  !(params[:software_ids].nil? || params[:project_ids].nil?)
            process_chart_with_all_variables_by_day(@softwares, @projects, @resources)
          end

          if  (params[:software_ids].nil? && !(params[:project_ids].nil?) )
            process_chart_with_projects_only_by_day(@projects, @resources)
          end

          if  (params[:project_ids].nil? && !(params[:software_ids].nil?))
            process_chart_with_softwares_only_by_day(@softwares, @resources)
          end

          if  (params[:project_ids].nil? && params[:software_ids].nil?)
            process_chart_with_resources_only_by_day(@resources)
          end

          format.html { render(:action=> "line_chart", :notice => 'chart was successfully created.') }
        end

        if (@type == "bar" || @type == "pie")
          
          if  !(params[:resource_ids].nil?)
            @resources = Resource.find(params[:resource_ids])
          end

          if  !(params[:software_ids].nil?)
            @softwares = Software.find(params[:software_ids])
          end
          if  !(params[:project_ids].nil?)
            @projects = Project.find(params[:project_ids]) 
          end

          if  !(params[:software_ids].nil? || params[:project_ids].nil?)
            process_chart_with_all_variables(@softwares, @projects, @resources)
          end

          if  (params[:software_ids].nil? && !(params[:project_ids].nil?) )
            process_chart_with_projects_only(@projects, @resources)
          end

          if  (params[:project_ids].nil? && !(params[:software_ids].nil?))
            process_chart_with_softwares_only(@softwares, @resources)
          end

          if  (params[:project_ids].nil? && params[:software_ids].nil?)
            process_chart_with_resources_only(@resources)
          end
          if @type == "bar"
          format.html { render(:action=> "bar_chart", :notice => 'chart was successfully created.') }
          end
          if @type == "pie"
          format.html { render(:action=> "pie_chart", :notice => 'chart was successfully created.') }
          end
        end       
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @chart.errors, :status => :unprocessable_entity }
      end
    end
  end

  def disk_space
    @chart = Chart.new
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @charts }
    end
  end

  def show_disk_space
    #raise params.to_yaml
    @chart = Chart.new(params[:chart])
    @data = []
    @type = params[:type]
    @from = @chart.from
    @to = @chart.to
    respond_to do |format|
      if @chart.valid?
        if @type == "line"
          if  !(params[:format_ids].nil?)
            @formats = Formato.find(params[:format_ids])
          end
          if  !(params[:software_ids].nil?)
            @softwares = Software.find(params[:software_ids])
          end
          if  !(params[:project_ids].nil?)
            @projects = Project.find(params[:project_ids]) 
          end
          if  !(params[:format_ids].nil? || params[:project_ids].nil?)
            process_chart_disk_space_format_project_by_day(@formats, @projects)
          end
          if  (params[:format_ids].nil? && !(params[:project_ids].nil?) && (params[:software_ids].nil?) )
            process_chart_disk_space_projects_only_by_day(@projects)
          end
          if  (params[:format_ids].nil? && !(params[:project_ids].nil?) && !(params[:software_ids].nil?) )
            process_chart_disk_space_software_project_by_day(@softwares, @projects)
          end
          if  (!(params[:format_ids].nil?) && (params[:project_ids].nil?) )
            process_chart_disk_space_formats_only_by_day(@formats)
          end
          if  (!(params[:software_ids].nil?) && (params[:project_ids].nil?) )
            process_chart_disk_space_softwares_only_by_day(@softwares)
          end
          format.html { render(:action=> "show_disk_space", :notice => 'chart was successfully created.') }
        end
        
       if (@type == "bar" || @type == "pie")
          if  !(params[:format_ids].nil?)
            @formats = Formato.find(params[:format_ids])
          end
          if  !(params[:software_ids].nil?)
            @softwares = Software.find(params[:software_ids])
          end
          if  !(params[:project_ids].nil?)
            @projects = Project.find(params[:project_ids]) 
          end
          if  !(params[:format_ids].nil? || params[:project_ids].nil?)
            process_chart_disk_space_format_project(@formats, @projects)
          end
          if  (params[:format_ids].nil? && !(params[:project_ids].nil?) && (params[:software_ids].nil?) )
            process_chart_disk_space_projects_only(@projects)
          end
          if  (params[:format_ids].nil? && !(params[:project_ids].nil?) && !(params[:software_ids].nil?) )
            process_chart_disk_space_software_project(@softwares, @projects)
          end
          if  (!(params[:format_ids].nil?) && (params[:project_ids].nil?) )
            process_chart_disk_space_formats_only(@formats)
          end
          if  (!(params[:software_ids].nil?) && (params[:project_ids].nil?) )
            process_chart_disk_space_softwares_only(@softwares)
          end
          if @type == "bar"
          format.html { render(:action=> "bar_chart", :notice => 'chart was successfully created.') }
          end
          if @type == "pie"
          format.html { render(:action=> "pie_chart", :notice => 'chart was successfully created.') }
          end
        end

      else
        format.html { render :action => "disk_space" }
        format.xml  { render :xml => @chart.errors, :status => :unprocessable_entity }
      end
    end
  end

  def test
    @chart = Chart.new()
    @type = params[:type]


  end

  def process_chart_disk_space_format_project_by_day(formats, projects)

    projects.each do |project|
      @sequences = project.sequences
      formats.each do |format|
        data1 = {}

        data1[:name] = "#{format.name} #{project.name}"
        data1[:data] = @sequences.find(
        :all,
        :select => "created_at, SUM(size) as data_attribute",
        :conditions => {:created_at => (@from)..(@to), :formato_id => format.id},
        :group => "created_at")
        if  !(data1[:data].nil? || data1[:data].empty?)
          @data << data1
        end
      end
    end
    return @data
  end

  def process_chart_disk_space_format_project(formats, projects)

    projects.each do |project|
      @sequences = project.sequences
      formats.each do |format|
        data1 = {}

        data1[:name] = "#{format.name} #{project.name}"
        data1[:data] = @sequences.find(
        :all,
        :select => "created_at, SUM(size) as data_attribute",
        :conditions => {:created_at => (@from)..(@to), :formato_id => format.id})
        if  !(data1[:data].nil? || data1[:data].empty?)
          @data << data1
        end
      end
    end
    return @data
  end
   
  def process_chart_disk_space_software_project_by_day(softwares, projects)

    projects.each do |project|
      @sequences = project.process_spaces
      softwares.each do |software|
        data1 = {}

        data1[:name] = "#{software.name} #{project.name}"
        data1[:data] = @sequences.find(
        :all,
        :select => "created_at, SUM(size) as data_attribute",
        :conditions => {:created_at => (@from)..(@to), :software_id => software.id},
        :group => "created_at")
        if  !(data1[:data].nil? || data1[:data].empty?)
          @data << data1
        end
      end
    end
    return @data
  end
  
  def process_chart_disk_space_software_project(softwares, projects)

    projects.each do |project|
      @sequences = project.process_spaces
      softwares.each do |software|
        data1 = {}

        data1[:name] = "#{software.name} #{project.name}"
        data1[:data] = @sequences.find(
        :all,
        :select => "created_at, SUM(size) as data_attribute",
        :conditions => {:created_at => (@from)..(@to), :software_id => software.id})
        if  !(data1[:data].nil? || data1[:data].empty?)
          @data << data1
        end
      end
    end
    return @data
  end

  def process_chart_disk_space_projects_only_by_day(projects)

    projects.each do |project|
      @sequences = project.sequences        
      data1 = {}

      data1[:name] = "#{project.name}"
      data1[:data] = @sequences.find(
      :all,
      :select => "created_at, SUM(size) as data_attribute",
      :conditions => {:created_at => (@from)..(@to)},
      :group => "created_at")

      @spaces = project.process_spaces
      data2 = {}

      data2[:name] = "#{project.name}"
      data2[:data] = @spaces.find(
      :all,
      :select => "created_at, SUM(size) as data_attribute",
      :conditions => {:created_at => (@from)..(@to)},
      :group => "created_at")
      for datapoint1 in data1[:data]
        for datapoint2 in data2[:data]
          if datapoint1.created_at == datapoint2.created_at
            datapoint1.data_attribute = (datapoint1.data_attribute.to_i + datapoint2.data_attribute.to_i)
          end
        end
      end
      if  !(data1[:data].nil? || data1[:data].empty?)
        @data << data1
      end             
    end
    return @data
  end
  
  def process_chart_disk_space_projects_only(projects)

    projects.each do |project|
      @sequences = project.sequences        
      data1 = {}

      data1[:name] = "#{project.name}"
      data1[:data] = @sequences.find(
      :all,
      :select => "created_at, SUM(size) as data_attribute",
      :conditions => {:created_at => (@from)..(@to)})

      @spaces = project.process_spaces
      data2 = {}

      data2[:name] = "#{project.name}"
      data2[:data] = @spaces.find(
      :all,
      :select => "created_at, SUM(size) as data_attribute",
      :conditions => {:created_at => (@from)..(@to)})
      for datapoint1 in data1[:data]
        for datapoint2 in data2[:data]
          if datapoint1.created_at == datapoint2.created_at
            datapoint1.data_attribute = (datapoint1.data_attribute.to_i + datapoint2.data_attribute.to_i)
          end
        end
      end
      if  !(data1[:data].nil? || data1[:data].empty?)
        @data << data1
      end             
    end
    return @data
  end

  def process_chart_disk_space_formats_only_by_day(formats)

    formats.each do |format|
      @sequences = format.sequences        
      data1 = {}

      data1[:name] = "#{format.name}"
      data1[:data] = @sequences.find(
      :all,
      :select => "created_at, SUM(size) as data_attribute",
      :conditions => {:created_at => (@from)..(@to)},
      :group => "created_at")
      if  !(data1[:data].nil? || data1[:data].empty?)
        @data << data1
      end
    end
    return @data
  end
  
  def process_chart_disk_space_formats_only(formats)

    formats.each do |format|
      @sequences = format.sequences        
      data1 = {}

      data1[:name] = "#{format.name}"
      data1[:data] = @sequences.find(
      :all,
      :select => "created_at, SUM(size) as data_attribute",
      :conditions => {:created_at => (@from)..(@to)})
      if  !(data1[:data].nil? || data1[:data].empty?)
        @data << data1
      end
    end
    return @data
  end

  def process_chart_disk_space_softwares_only_by_day(softwares)

    softwares.each do |software|
      @spaces = software.process_spaces        
      data1 = {}

      data1[:name] = "#{software.name}"
      data1[:data] = @spaces.find(
      :all,
      :select => "created_at, SUM(size) as data_attribute",
      :conditions => {:created_at => (@from)..(@to)},
      :group => "created_at")
      if  !(data1[:data].nil? || data1[:data].empty?)
        @data << data1
      end
    end
    return @data
  end
  
  def process_chart_disk_space_softwares_only(softwares)

    softwares.each do |software|
      @spaces = software.process_spaces        
      data1 = {}

      data1[:name] = "#{software.name}"
      data1[:data] = @spaces.find(
      :all,
      :select => "created_at, SUM(size) as data_attribute",
      :conditions => {:created_at => (@from)..(@to)})
      if  !(data1[:data].nil? || data1[:data].empty?)
        @data << data1
      end
    end
    return @data
  end

  def process_chart_with_all_variables_by_day(softwares, projects, resources)

    softwares.each do |software|
      @jobs = software.jobs
      projects.each do |project|
        resources.each do |resource|
          data1 = {}

          data1[:name] = "#{resource.view_name} #{software.name} #{project.name}"
          data1[:data] = @jobs.find(
          :all,
          :select => "day, SUM(#{resource.name}) as data_attribute",
          :conditions => {:day => (@from)..(@to), :project_id => project.id},
          :group => "day")
          if  !(data1[:data].nil? || data1[:data].empty?)
            @data << data1
          end
        end
      end
    end
    return @data
  end

  def process_chart_with_projects_only_by_day(projects, resources)
    projects.each do |project|
      @jobs = project.jobs
      resources.each do |resource|
        data1 = {}

        data1[:name] = "#{resource.view_name} #{project.name}"
        data1[:data] = @jobs.find(
        :all,
        :select => "day, SUM(#{resource.name}) as data_attribute",
        :conditions => {:day => (@from)..(@to)},
        :group => "day")
        if  !(data1[:data].nil? || data1[:data].empty?)
          @data << data1
        end
      end
    end
    return @data 
  end

  def process_chart_with_softwares_only_by_day(softwares, resources)
    softwares.each do |software|
      procesos = software.procesos
      @jobs = software.jobs

      @resources.each do |resource|
        data1 = {}

        data1[:name] = "#{resource.view_name} #{software.name}"
        data1[:data] = @jobs.find(
        :all,
        :select => "day, SUM(#{resource.name}) as data_attribute",
        :conditions => {:day => (@from)..(@to)},
        :group => "day")
        if  !(data1[:data].nil? || data1[:data].empty?)
          @data << data1
        end
      end
    end
    return @data 
  end

  def process_chart_with_resources_only_by_day(resources)
    resources.each do |resource|
      data1 = {}
      data1[:name] = "#{resource.view_name}"
      data1[:data] = Job.find(
      :all,
      :select => "day, SUM(#{resource.name}) as data_attribute",
      :conditions => {:day => (@from)..(@to)},
      :group => "day")
      if  !(data1[:data].nil? || data1[:data].empty?)
        @data << data1
      end
    end
    return @data 
  end

  def process_chart_with_resources_only(resources)
    resources.each do |resource|
      data1 = {}
      data1[:name] = "#{resource.view_name}"
      data1[:data] = Job.find(
      :all,
      :select => "SUM(#{resource.name}) as data_attribute",
      :conditions => {:day => (@from)..(@to)})
      if  !(data1[:data].nil? || data1[:data].empty?)
        @data << data1
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

        data1[:name] = "#{resource.view_name} #{software.name}"
        data1[:data] = @jobs.find(
        :all,
        :select => "SUM(#{resource.name}) as data_attribute",
        :conditions => {:day => (@from)..(@to)})
        if  !(data1[:data].nil? || data1[:data].empty?)
          @data << data1
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

        data1[:name] = "#{resource.view_name} #{project.name}"
        data1[:data] = @jobs.find(
        :all,
        :select => "day, SUM(#{resource.name}) as data_attribute",
        :conditions => {:day => (@from)..(@to)})
        if  !(data1[:data].nil? || data1[:data].empty?)
          @data << data1
        end
      end
    end
    return @data 
  end

  def process_chart_with_all_variables(softwares, projects, resources)

    softwares.each do |software|
      @jobs = software.jobs
      projects.each do |project|
        resources.each do |resource|
          data1 = {}

          data1[:name] = "#{resource.view_name} #{software.name} #{project.name}"
          data1[:data] = @jobs.find(
          :all,
          :select => "SUM(#{resource.name}) as data_attribute",
          :conditions => {:day => (@from)..(@to), :project_id => project.id})
          if  !(data1[:data].nil? || data1[:data].empty?)
            @data << data1
          end
        end
      end
    end
    return @data
  end

end
