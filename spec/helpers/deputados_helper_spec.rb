require "spec_helper"

describe DeputadosHelper do

  let(:id_cadastro)  { 1 }
  let(:url_deputado) { helper.detalhe_deputado_url(id_cadastro) }
  let(:url_despesa)  { helper.cota_deputado_url(id_cadastro)    }

  context "url do detalhe sobre o deputado" do
    subject { url_deputado }
    it { should include(id_cadastro.to_s) }
  end

  context "url do detalhe sobre a despesa" do
    subject { url_despesa }
    it { should include(id_cadastro.to_s) }
  end

end