class HomeController < ApplicationController

  layout 'search'

  def index
    @deputados = Deputado.top_tres
  end
end
