Rails.application.routes.draw do

  root 'home#index'
  get '/aleatorio'   => 'home#aleatorio',   as: 'aleatorio'
  get '/gasto_total' => 'home#gasto_total', as: 'gasto_total', defaults: { format: :json }

  resources :deputados do
  	resources :despesas, :module => :deputados
  end
end
