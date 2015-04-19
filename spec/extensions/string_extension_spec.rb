require 'spec_helper'

describe 'String Extension' do
  context 'JOSÉ DA SILVA em forma de título' do
    let(:name) { 'JOSÉ DA SILVA'.titleize_name }

    it 'deve ser igual a José da Silva' do
      expect(name.titleize_name).to eq 'José da Silva'
    end
  end
end
