class DeputadosController < ApplicationController

  layout 'search'

  def index
     @deputados = Deputado.todos(params[:q], params[:page])
     respond_to do |format|
        format.html
     end
  end

  def show
  	@deputado = Deputado.find(params[:id])
  	@despesas = @deputado.despesas.todos(params[:q], params[:page])
  end

end
