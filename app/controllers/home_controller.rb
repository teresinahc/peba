class HomeController < ApplicationController

  layout 'search'

  def index
  end

  def aleatorio
    deputado = Deputado.aleatorios.first
    redirect_to deputado_path deputado
  end
end
