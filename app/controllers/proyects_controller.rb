class ProyectsController < ApplicationController
  # GET /proyects
  # GET /proyects.xml
  def index
    @proyects = Proyect.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @proyects }
    end
  end

  # GET /proyects/1
  # GET /proyects/1.xml
  def show
    @proyect = Proyect.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @proyect }
    end
  end

  # GET /proyects/new
  # GET /proyects/new.xml
  def new
    @proyect = Proyect.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @proyect }
    end
  end

  # GET /proyects/1/edit
  def edit
    @proyect = Proyect.find(params[:id])
  end

  # POST /proyects
  # POST /proyects.xml
  def create
    @proyect = Proyect.new(params[:proyect])

    respond_to do |format|
      if @proyect.save
        format.html { redirect_to(@proyect, :notice => 'Proyect was successfully created.') }
        format.xml  { render :xml => @proyect, :status => :created, :location => @proyect }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @proyect.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /proyects/1
  # PUT /proyects/1.xml
  def update
    @proyect = Proyect.find(params[:id])

    respond_to do |format|
      if @proyect.update_attributes(params[:proyect])
        format.html { redirect_to(@proyect, :notice => 'Proyect was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proyect.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /proyects/1
  # DELETE /proyects/1.xml
  def destroy
    @proyect = Proyect.find(params[:id])
    @proyect.destroy

    respond_to do |format|
      format.html { redirect_to(proyects_url) }
      format.xml  { head :ok }
    end
  end
end
