Rails.application.routes.draw do
  
  root 'home#index'

  resources :deputados do
    collection { get :search }
  end

end
