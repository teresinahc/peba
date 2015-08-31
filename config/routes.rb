Rails.application.routes.draw do

  root 'home#index'
  get '/aleatorio'   => 'home#aleatorio',   as: 'aleatorio'
  get '/gasto_total' => 'home#gasto_total', as: 'gasto_total', defaults: { format: :json }
  get '/sitemap.xml' => 'home#sitemap',     as: 'sitemap', defaults: { format: :xml }

  resources :deputados do
  	resources :despesas, :module => :deputados
  end
end
