Rails.application.routes.draw do
  #resources :tags
  #resources :quotes
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/quotes/:quote', to: 'quotes#showw'
end
