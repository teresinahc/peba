require 'rails_helper'

describe Despesa, type: :model do
  it { is_expected.to belong_to(:deputado) }

  describe '#total_gasto' do
    subject { Despesa }

    before do
      create(:despesa)
      create(:despesa, num_ano: 2014, valor_liquido: 102.0)
    end

    it 'should return sum of valor_liquido' do
      expect(subject.total_gasto).to eq '112.0'
    end
  end

  describe '#totais_por_descricao' do
    subject { Despesa }

    before do
      create(:despesa)
      create(:despesa, descricao: 'Caixa 2', num_ano: 2014, valor_liquido: 102.0, valor_documento: 100.0)
      create(:despesa, descricao: 'Caixa 2', num_ano: 2014, valor_liquido: 1.0, valor_documento: 2.0)
    end

    context 'when checking for descricao expense' do
      let(:content) do
        subject.totais_por_descricao.select { |arr| arr[:descricao] == 'descricao' }[0]
      end

      it 'should return correct descricao' do
        expect(content[:descricao]).to eq 'descricao'
      end

      it 'should return sum of valor_liquido' do
        expect(content[:total_liquido]).to eq 10.0
      end

      it 'should return sum of valor_documento' do
        expect(content[:total]).to eq 10.0
      end
    end

    context 'when checking for Caixa 2 expense' do
      let(:content) do
        subject.totais_por_descricao.select { |arr| arr[:descricao] == 'Caixa 2' }[0]
      end

      it 'should return correct descricao' do
        expect(content[:descricao]).to eq 'Caixa 2'
      end

      it 'should return sum of valor_liquido' do
        expect(content[:total_liquido]).to eq 103.0
      end

      it 'should return sum of valor_documento' do
        expect(content[:total]).to eq 102.0
      end
    end
  end

  # TODO
  # Change this to return something like:
  #
  #     { 2015 => { 1 => 0.0, 2 => 1.0, … } }
  describe '#mensal' do
    subject { Despesa }

    before do
      create(:despesa)
      create(:despesa, num_ano: 2014, valor_liquido: 12.0)
    end

    let(:content) { subject.mensal.reduce({}) { |h, pairs| h.merge(pairs) } }

    context 'when the year is 2014' do
      it 'should have the correct key' do
        expect(content).to have_key(2014)
      end

      it 'should have the correct content' do
        expect(content[2014]).to include(1 => 12.0)
      end
    end

    context 'when the year is 2015' do
      it 'should have the correct key' do
        expect(content).to have_key(2015)
      end

      it 'should have the correct content' do
        expect(content[2015]).to include(1 => 10.0)
      end
    end

    context 'when the year is 2016' do
      it 'should not have the key' do
        expect(content).not_to have_key(2016)
      end
    end
  end

  describe '#anual' do
    subject { Despesa }

    before do
      create(:despesa)
      create(:despesa, num_ano: 2014, valor_liquido: 11.0)
    end

    context 'when the year is 2014' do
      it 'should have the key' do
        expect(subject.anual).to have_key(2014)
      end

      it 'should have the key' do
        expect(subject.anual[2014]).to eq('11.0')
      end
    end

    context 'when the year is 2015' do
      it 'should have the key' do
        expect(subject.anual).to have_key(2015)
      end

      it 'should have the key' do
        expect(subject.anual[2015]).to eq('10.0')
      end
    end

    it 'should not return anual sum for 2016' do
      expect(subject.anual).not_to have_key(2016)
    end
  end

  describe '#total_of_cost' do
    subject { Despesa }

    before do
      create(:despesa)
      create(:despesa, num_ano: 2014, valor_liquido: 11.0)
      create(:despesa, num_ano: 2014, valor_liquido: -25.0)
    end

    context 'when the returned value is' do
      it 'negative' do
        expect(subject.total_of_cost).to eq('-4.0')
      end
    end

  end
end
