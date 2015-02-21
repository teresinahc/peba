class DeputadosController < ApplicationController
  def index
     @deputados = Deputado.order(:nome).paginate(:page=>params[:page], :per_page=>5)
     respond_to do |format|
        format.html
        format.json { render json: @deputados } 
     end
  end

  def show
  	@deputado = Deputado.find(params[:id])
  	@despesas = @deputado.despesas.paginate(:page=>params[:page], :per_page=>10)
  end
end
