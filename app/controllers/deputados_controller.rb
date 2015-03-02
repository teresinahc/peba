class DeputadosController < ApplicationController
  def index
     @deputados = Deputado.todos(params[:q], params[:page])
     respond_to do |format|
        format.html
     end
  end

  def show
  	@deputado = Deputado.com_total_despesas.find(params[:id])
  	@despesas = @deputado.despesas.todos(params[:q], params[:page])
    
    @page_info = {
      title: 'Deputado: ' + @deputado.nome.titleize
    }

    @opengraph = {
      title:      'Deputado: ' + @deputado.nome.titleize,
      type:       'website',
      url:        url_for(:only_path => false, :overwrite_params=>nil),
      image:      @deputado.url_foto,
      site_name: 'Peba'
    }
  end

end
