class ProcessSpacesController < ApplicationController
  # GET /process_spaces
  # GET /process_spaces.xml
  def index
    @process_spaces = ProcessSpace.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @process_spaces }
    end
  end

  def freedisk
    @spaces = []
     @projects = Project.all
     @softwares = Software.all
     for project in @projects do
       for software in @softwares do
     @spaces += ProcessSpace.disk_free(project, software)
         for space in @spaces do
           @split = space.name.split('/')
           space.project = Project.find_by_name(@split[7])
           space.software = Software.find_by_name(@split[9])
           space.save
         end
       end
     end
   end

  # GET /process_spaces/1
  # GET /process_spaces/1.xml
  def show
    @process_space = ProcessSpace.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @process_space }
    end
  end

  # GET /process_spaces/new
  # GET /process_spaces/new.xml
  def new
    @process_space = ProcessSpace.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @process_space }
    end
  end

  # GET /process_spaces/1/edit
  def edit
    @process_space = ProcessSpace.find(params[:id])
  end

  # POST /process_spaces
  # POST /process_spaces.xml
  def create
    @process_space = ProcessSpace.new(params[:process_space])

    respond_to do |format|
      if @process_space.save
        format.html { redirect_to(@process_space, :notice => 'ProcessSpace was successfully created.') }
        format.xml  { render :xml => @process_space, :status => :created, :location => @process_space }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @process_space.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /process_spaces/1
  # PUT /process_spaces/1.xml
  def update
    @process_space = ProcessSpace.find(params[:id])

    respond_to do |format|
      if @process_space.update_attributes(params[:process_space])
        format.html { redirect_to(@process_space, :notice => 'ProcessSpace was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @process_space.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /process_spaces/1
  # DELETE /process_spaces/1.xml
  def destroy
    @process_space = ProcessSpace.find(params[:id])
    @process_space.destroy

    respond_to do |format|
      format.html { redirect_to(process_spaces_url) }
      format.xml  { head :ok }
    end
  end
end
