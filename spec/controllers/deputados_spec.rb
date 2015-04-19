require 'rails_helper'

describe DeputadosController, type: :controller do
  before(:each) { @deputado = Deputado.create! FactoryGirl.attributes_for(:deputado) }

  render_views

  describe 'GET #index' do
    context 'via json' do
      it 'deve listar os deputados e exibe os atributos corretamente' do
        get :index, format: :json

        json = JSON.parse(response.body)
        espero_que(json).tenha %w(deputados total)

        amostra = json['deputados'].first
        espero_que(amostra).tenha %w(id nome email partido uf url_foto total_despesas total_votos
                                      porcentagem_votos situacao_candidatura)
      end
    end

    context 'via html' do
      before(:each) { get :index}

      it 'deve exibir total de votos' do
        expect(response.body).to have_content('votos')
      end

      it 'deve exibir link Início' do
        expect(response.body).to have_link('Início')
      end

      it 'deve exibir campo de busca no rodapé' do
        expect(response.body).to have_selector('footer .search')
      end
    end

    context 'busca' do
      it 'deve retornar resultado para cada parametro' do
        [:nome, :nome_parlamentar, :partido, :matricula, :url_foto, :email, :uf].each do |attr|
          get :index, params: {q: @deputado[attr]}, format: :json
          expect(response.body).to_not be_blank
        end
      end

      it 'nao deve exibir logo no cover' do
        get :index, params: {q: @deputado[:nome]}
        expect(response.body).to_not have_selector('#logo')
      end
    end
  end


  describe 'GET #show' do
    before(:each) { @deputado.despesas << FactoryGirl.build(:despesa) }

    context 'via json' do
      it 'deve exibir o deputado e os atributos corretamente' do
        get :show, id: @deputado.id, format: :json

        json = JSON.parse(response.body)
        espero_que(json).tenha %w(id nome email partido uf url_foto total_despesas total_votos fonte despesas
                                  porcentagem_votos situacao_candidatura)

        amostra_despesa = json['despesas'].first
        espero_que(amostra_despesa).tenha %w(tipo total total_liquido)
      end
    end

    context 'via html' do
      it 'deve exibir o total de votos, votos validos e situacao' do
        get :show, id: @deputado.id

        expect(response.body).to have_content('votos')
        expect(response.body).to have_content('votos válidos')
        expect(response.body).to have_content(@deputado.situacao_candidatura)
      end
    end
  end
end
