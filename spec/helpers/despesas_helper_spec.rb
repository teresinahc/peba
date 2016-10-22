require 'spec_helper'

describe ApplicationHelper do
  before do
    create(:despesa, valor_liquido: 10, valor_documento: 100, deputado_id: deputy.id)
    create(:despesa, valor_liquido: 12, valor_documento: 120, deputado_id: deputy.id)

    DeputadosIndex.purge!
    DeputadosIndex.import
  end

  let(:deputy) { create(:deputado, nome: "Deputado") }
  let(:sum_of_value) { helper.sum_partial_of_document_value(deputy.despesas) }

  context 'Sum of the total amounts of documents' do
    it { expect(sum_of_value).to be(220.to_f) }
  end

end
