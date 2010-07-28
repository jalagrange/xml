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
    @jobs_diarios = @jobs.find(:all,
                               :select => "jobs.created_at, walltime, day, SUM(jobs.walltime) as walltime",
                               :group => "day")
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
