require 'rails_helper'

describe Deputados::DespesasController, type: :controller do
  before(:each) do
    @deputado = Deputado.create! FactoryGirl.attributes_for(:deputado)
    @deputado.despesas << FactoryGirl.build(:despesa)
  end

  render_views

  describe 'GET #index' do
    context 'via json' do
      it 'deve listar as despesas e exibir os atributos corretamente' do
        get :index, deputado_id: @deputado.id, format: :json

        json = JSON.parse(response.body)

        amostra = json.first
        espero_que(amostra).tenha %w(data_emissao beneficiario cpf_cnpf valor_liquido valor_glosa valor_documento url_recibo)
      end
    end
  end
end