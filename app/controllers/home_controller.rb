class HomeController < ApplicationController
  def index
    @page_info = {
      title: 'Indexador de Dados Públicos',
      description:  'O Peba é sistema que indexa em fonte única informações relacionadas às despesas de vários entidades governamentais com suporte para filtros e buscas avançadas.'
    }
    @opengraph = {
      title:        'Peba - Indexador de Dados Públicos',
      type:         'website',
      url:          request.base_url,
      image:        request.base_url + view_context.image_path('peba_logo_og.png'),
      site_name:    'Peba',
      description:  'O Peba é um sistema que indexa em fonte única informações relacionadas às despesas de vários entidades governamentais com suporte para filtros e buscas avançadas.'
    }
  end


  def gasto_total
    @gastos = Despesa.por_mes
  end


  def aleatorio
    deputado = Deputado.aleatorios.first
    redirect_to deputado_path deputado
  end
end
