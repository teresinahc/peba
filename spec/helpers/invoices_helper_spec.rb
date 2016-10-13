require "spec_helper"

describe InvoicesHelper do

  let(:invoice) { create(:despesa, nu_deputado_id: '12345', num_ano: 2015, ide_documento: '12345') }

  describe '#build_receipt_url' do
    it "should return corret url" do
      url = helper.build_receipt_url(invoice.nu_deputado_id, invoice.num_ano, invoice.ide_documento)

      expect(url).to eq('http://www.camara.leg.br/cota-parlamentar/documentos/publ/12345/2015/12345.pdf')
    end
  end

end
