class HomeController < ApplicationController
  def index
    @page_info = {
      title: 'Indexador de Dados Públicos',
      description:  'O Peba é um sistema que indexa em fonte única informações relacionadas às despesas de vários entidades ' <<
                    'governamentais com suporte para filtros e buscas avançadas.'
    }
    @opengraph = {
      title:        'Peba - Indexador de Dados Públicos',
      type:         'website',
      url:          root_url,
      image:        view_context.image_url('peba_logo_og.png'),
      site_name:    'Peba',
      description:  'O Peba é um sistema que indexa em fonte única informações relacionadas às despesas de vários entidades ' <<
                    'governamentais com suporte para filtros e buscas avançadas.'
    }
  end


  def gasto_total
    @gastos = Despesa.mensal params[:deputado_id]
  end


  def aleatorio
    deputado = Deputado.aleatorios.first
    redirect_to deputado_path deputado
  end

  def sitemap
    @host      = 'http://peba.teresinahc.org/'
    @politicos = Deputado.all

    respond_to do |format|
      format.xml { render 'sitemap/index', layout: nil }
    end
  end
end
