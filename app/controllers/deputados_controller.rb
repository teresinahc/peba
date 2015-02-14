class DeputadosController < ApplicationController
  def index
     @deputados = Deputado.paginate(:page=>params[:page], :per_page=>5)
     respond_to do |format|
        format.html
        format.json { render json: @deputados } 
     end
  end

  def show
  end
end
