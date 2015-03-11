require 'rails_helper'

describe Deputado, type: :model do
  it { should have_many(:despesas) }

  context 'busca' do
    it 'busca por nome indenpendente da acentuação ou case' do
      attrs    = FactoryGirl.attributes_for(:deputado).merge nome: "JOSÉ"
      deputado = Deputado.create! attrs

      %w(JOSE JOSÉ jose josé José Jose).each do |attr|
        expect(Deputado.buscar attr).to_not be_nil
      end
    end

  end
end