class DeputadosController < ApplicationController
  def index
     @deputados = Deputado.maiores_despesas
                          .paginate(:page=>params[:page], :per_page=>10)
     respond_to do |format|
        format.html
        format.json { render json: @deputados } 
     end
  end

  def search
    @deputados = Deputado.search { fulltext params[:q] }.results

    render action: "index"
  end

  def show
  	@deputado = Deputado.find(params[:id])
  	@despesas = @deputado.despesas
                         .mais_novos
                         .paginate(:page=>params[:page], :per_page=>20)
  end
end
