class DeputadosController < ApplicationController

  layout 'search'

  def index
     @deputados = Deputado.todos(params[:q], params[:page])
     respond_to do |format|
        format.html
     end
  end

  def show
  	@deputado = Deputado.com_total_despesas.find(params[:id])
  	@despesas = @deputado.despesas.todos(params[:q], params[:page])
  end

end
