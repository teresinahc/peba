Rails.application.routes.draw do
  
  root 'home#index'
  get  '/aleatorio' => 'home#aleatorio', as: 'aletaroio'
  
  resources :deputados do
  	resources :despesas, :module => :deputados
  end

end
