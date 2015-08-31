require 'rails_helper'

describe HomeController, type: :controller do
  render_views

  describe 'GET #index' do
    before(:each) { get :index}

    it 'não deve exibir link de Início' do
      expect(response.body).to_not have_link('Início')
    end

    it 'não deve exibir campo de busca no rodapé' do
      expect(response.body).to_not have_selector('footer .search')
    end

    it 'deve exibir links de redes sociais no navbar' do
      expect(response.body).to have_selector('.nav .social')
    end
  end

  describe 'GET #sitemap' do
    it 'deve exibir sitemap corretamente' do
      get :sitemap, format: :xml

      expect(response.body).to have_selector('urlset')
      expect(response.body).to have_selector('url')
    end
  end

  # describe 'GET #gasto_total' do
  #   it 'deve exibir json com gastos anuais mes a mes'
  # end
end
