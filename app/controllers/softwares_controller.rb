class SoftwaresController < ApplicationController
  # GET /softwares
  # GET /softwares.xml
  def index
    @softwares = Software.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @softwares }
    end
  end
  
  def stats
     @softwares = Software.all

     respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @softwares }
     end
   end

  # GET /softwares/1
  # GET /softwares/1.xml
  def show
    @software = Software.find(params[:id])
    @procesos = @software.procesos
    @jobs = @software.jobs
    @data = []
    
    data1 = {}
    data2 = {}
    data3 = {}
    data4 = {}
    data1[:name] = "Virtual Memory"
    data1[:data] = @jobs.total_virtual_memory_by_day
    data2[:name] = "Memory"
    data2[:data] = @jobs.total_memory_by_day
    data3[:name] = "Queue Time"
    data3[:data] = @jobs.total_queue_time_by_day
    data4[:name] = "Wall Time"
    data4[:data] = @jobs.total_walltime_by_day
    @data << data1
    @data << data2
    @data << data3
    @data << data4
    

    

    
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @software }
    end
  end

  # GET /softwares/new
  # GET /softwares/new.xml
  def new
    @software = Software.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @software }
    end
  end

  # GET /softwares/1/edit
  def edit
    @software = Software.find(params[:id])
  end

  # POST /softwares
  # POST /softwares.xml
  def create
    @software = Software.new(params[:software])

    respond_to do |format|
      if @software.save
        format.html { redirect_to(@software, :notice => 'Software was successfully created.') }
        format.xml  { render :xml => @software, :status => :created, :location => @software }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @software.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /softwares/1
  # PUT /softwares/1.xml
  def update
    @software = Software.find(params[:id])

    respond_to do |format|
      if @software.update_attributes(params[:software])
        format.html { redirect_to(@software, :notice => 'Software was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @software.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /softwares/1
  # DELETE /softwares/1.xml
  def destroy
    @software = Software.find(params[:id])
    @software.destroy

    respond_to do |format|
      format.html { redirect_to(softwares_url) }
      format.xml  { head :ok }
    end
  end
end
