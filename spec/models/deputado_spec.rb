require 'rails_helper'

describe Deputado, type: :model do
  it { is_expected.to have_many(:despesas) }

  describe '#slug' do
    it 'should return nome_parlamentar parameterized' do
      subject.nome_parlamentar = 'José Augusto'
      expect(subject.slug).to eq 'jose-augusto'
    end
  end

  describe '#to_param' do
    it 'should return id and slug' do
      subject.id = 66
      subject.nome_parlamentar = 'José Augusto'
      expect(subject.to_param).to eq '66-jose-augusto'
    end
  end
end
