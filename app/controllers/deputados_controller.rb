class DeputadosController < ApplicationController

  def index
     @deputados = Deputado.todos(params[:q], params[:page])
     respond_to do |format|
        format.html
     end
  end

  def show
  	@deputado = Deputado.find(params[:id])
  	@despesas = @deputado.despesas
                         .mais_novos
                         .paginate(:page=>params[:page], :per_page=>20)
  end

end
