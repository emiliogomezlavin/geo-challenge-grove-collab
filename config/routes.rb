Rails.application.routes.draw do
  resources :stores
  
  get 'search', to: 'stores#search'
  post 'find_store', to: 'stores#find_store'
  
end
