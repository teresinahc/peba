module FeatureHelpers
  ###############################################################################################
  # Metodos aninhados utilizados para verificar se a saida em json contenha as chaves requeridas
  #
  # Exemplo:
  # espero_que(json).tenha %w(id nome tipo)
  ###############################################################################################
  def espero_que(amostra)
    @amostra = amostra
    self
  end

  def tenha(attrs)
    attrs.each do |attr|
      expect(@amostra).to include(attr)
    end
  end
end