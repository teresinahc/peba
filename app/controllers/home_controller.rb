class HomeController < ApplicationController
  def index
    @page_info = {
      title: 'Indexador de Dados Públicos',
      description:  app_description
    }
    @opengraph = {
      title:        'Peba - Indexador de Dados Públicos',
      type:         'website',
      url:          request.base_url,
      image:        request.base_url + view_context.image_path('peba_logo_og.png'),
      site_name:    'Peba',
      description:  app_description
    }
  end


  def gasto_total
    @gastos = Despesa.mensal
  end


  def aleatorio
    deputado = Deputado.aleatorios.first
    redirect_to deputado_path deputado
  end
end
