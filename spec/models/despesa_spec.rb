require 'rails_helper'

describe Despesa, type: :model do
  it { should belong_to(:deputado) }

  context 'gasto total' do
    it 'deve exibir gastos anuais mes a mes'
  end
end
