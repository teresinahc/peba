module Crawler
  
  module Scrapers
    autoload :Base
    module CamaraDeputados
      autoload :Deputados
    end
  end

  class Engine
    def self.run
      puts 'Rodando'   
    end
  end

end