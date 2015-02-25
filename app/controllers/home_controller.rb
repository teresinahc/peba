class HomeController < ApplicationController

  layout 'search'

  def index
    @deputados = Rails.cache.fetch('deputados_aleatorios', :expires_in => 1.minutes) { Deputado.top_tres }
  end
end
