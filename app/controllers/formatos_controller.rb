class FormatosController < ApplicationController
  # GET /formatos
  # GET /formatos.xml
  def index
    @formatos = Formato.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @formatos }
    end
  end

  # GET /formatos/1
  # GET /formatos/1.xml
  def show
    @formato = Formato.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @formato }
    end
  end

  # GET /formatos/new
  # GET /formatos/new.xml
  def new
    @formato = Formato.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @formato }
    end
  end

  # GET /formatos/1/edit
  def edit
    @formato = Formato.find(params[:id])
  end

  # POST /formatos
  # POST /formatos.xml
  def create
    @formato = Formato.new(params[:formato])

    respond_to do |format|
      if @formato.save
        format.html { redirect_to(@formato, :notice => 'Formato was successfully created.') }
        format.xml  { render :xml => @formato, :status => :created, :location => @formato }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @formato.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /formatos/1
  # PUT /formatos/1.xml
  def update
    @formato = Formato.find(params[:id])

    respond_to do |format|
      if @formato.update_attributes(params[:formato])
        format.html { redirect_to(@formato, :notice => 'Formato was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @formato.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /formatos/1
  # DELETE /formatos/1.xml
  def destroy
    @formato = Formato.find(params[:id])
    @formato.destroy

    respond_to do |format|
      format.html { redirect_to(formatos_url) }
      format.xml  { head :ok }
    end
  end
end
