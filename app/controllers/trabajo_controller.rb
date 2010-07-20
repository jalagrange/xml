
class TrabajoController < ApplicationController
 
  def show
    @trabajos = Trabajo.find_all(params[:id])
  end
  
  def create
    @trabajos = Trabajo.find_all(params[:id])
  end
end