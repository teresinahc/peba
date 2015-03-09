require 'rails_helper'

describe DeputadosController, type: :controller do
  before(:each) { @deputado = Deputado.create! FactoryGirl.attributes_for(:deputado) }

  render_views

  describe 'GET #index' do
    context 'via json' do
      it 'lista os deputados e exibe os atributos corretamente' do
        get :index, format: :json

        json = JSON.parse(response.body)
        espero_que(json).tenha %w(deputados total)

        amostra = json['deputados'].first
        espero_que(amostra).tenha %w(id nome email partido uf url_foto total_despesas)
      end
    end

    context 'busca' do
      it 'retorna resultado para cada parametro' do
        [:nome, :nome_parlamentar, :partido, :matricula, :url_foto, :email, :uf].each do |attr|
          get :index, params: {q: @deputado[attr]}, format: :json

          expect(response.body).to_not be_blank
        end
      end
    end
  end


  describe 'GET #show' do
    before(:each) { @deputado.despesas << FactoryGirl.build(:despesa) }

    context 'via json' do
      it 'exibe o deputado e os atributos corretamente' do
        get :show, id: @deputado.id, format: :json

        json = JSON.parse(response.body)
        espero_que(json).tenha %w(id nome email partido uf url_foto total_despesas fonte despesas)

        amostra_despesa = json['despesas'].first
        espero_que(amostra_despesa).tenha %w(tipo total total_liquido)
      end
    end
  end
end