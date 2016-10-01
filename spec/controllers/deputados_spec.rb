require 'rails_helper'

describe DeputadosController, type: :controller do
  before do
    create(:despesa, valor_liquido: 10, valor_documento: 100, deputado_id: deputy.id)
    create(:despesa, valor_liquido: 12, valor_documento: 120, deputado_id: deputy.id)

    create(:despesa, valor_liquido: 13, valor_documento: 130, deputado_id: john_doe.id)

    DeputadosIndex.purge!
    DeputadosIndex.import
  end

  let(:deputy) { create(:deputado, nome: "Deputado") }
  let(:john_doe) { create(:john_doe) }

  render_views

  describe 'GET #index' do
    context 'when using json' do
      it 'should list deputies' do
        get :index, q: "Deputado", format: :json

        json = JSON.parse(response.body)

        expect(json.size).to be(1)
      end

      it 'should not list non-matching deputy' do
        get :index, q: "Deputado", format: :json

        expect(response.body).not_to match("John Doe")
      end

      context 'should correct return attributes for matching deputies' do
        before do
          get :index, q: deputy.nome, format: :json
        end

        it { expect(response.body).to match(%r["id":#{deputy.id}]) }
        it { expect(response.body).to match(%r["total_votos":#{deputy.total_votos}]) }
        it { expect(response.body).to match(%r["porcentagem_votos":#{deputy.porcentagem_votos}]) }
        it { expect(response.body).to match(%r["total_despesas":"R\$ 22,00"]) }

        %w(nome email partido uf url_foto situacao_candidatura).each do |attribute|
          it { expect(response.body).to match(%r["#{attribute}":"#{deputy.send(attribute)}"]) }
        end
      end

      %w[nome nome_parlamentar partido matricula email uf].each do |param|
        context "should search using #{param} attribute from deputy" do
          it 'and returns correct deputy' do
            get :index, q: deputy.send(param), format: :json

            expect(response.body).to match deputy.nome
          end

          it 'and does not return incorrect deputy' do
            get :index, q: deputy.send(param), format: :json

            expect(response.body).not_to match 'John Doe'
          end
        end
      end
    end

    context 'when using html' do
      before do
        get :index, q: deputy.nome
      end

      it { expect(response.body).to have_content(deputy.nome_parlamentar) }
      it { expect(response.body).to have_content('Partido: PDSK') }
      it { expect(response.body).to have_content('Estado: KD') }
      it { expect(response.body).to have_content('Total de votos: 123') }
      it { expect(response.body).to have_content('Despesas: R$ 22,00') }

      it 'should not show info about non-matching deputy' do
        expect(response.body).not_to have_content('John Doe')
      end
    end
  end

  describe 'GET #show' do
    context 'when using json' do
      context 'should return correct information' do
        before { get :show, id: deputy.id, format: :json }

        it { expect(response.body).to match %q[tipo":"descricao] }
        it { expect(response.body).to match %q[total":"R\$ 220,00] }
        it { expect(response.body).to match %q[total_liquido":"R\$ 22,00] }
      end
    end

    context 'when using html' do
      before { get :show, id: deputy.id }

      context 'should return correct infomation' do
        it { expect(response.body).to have_content('123 votos') }
        it { expect(response.body).to have_content('10,00% votos válidos') }
        it { expect(response.body).to have_content('Eleito') }
      end

      context 'should correct return @opengraph' do
        it { expect(assigns(:opengraph)).to include(title: "Deputado: Deputado") }
        it { expect(assigns(:opengraph)).to include(type: "website") }
        it { expect(assigns(:opengraph)).to include(url: "http://test.host/deputados/#{deputy.id}") }
        it { expect(assigns(:opengraph)).to include(image: "http://url.com/foto") }
        it { expect(assigns(:opengraph)).to include(site_name: "Peba") }
      end
    end
  end
end
