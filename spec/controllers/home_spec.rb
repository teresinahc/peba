require 'rails_helper'

describe HomeController, type: :controller do
  render_views

  describe 'GET #index' do
    it 'não deve aparecer link de Início' do
      get :index

      expect(response.body).to_not have_link('Início')
    end
  end
end
