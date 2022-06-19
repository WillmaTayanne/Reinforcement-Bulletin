Rails.application.routes.draw do
  post 'login', to: 'usuarios#login'
  resources :usuarios, only: [:create, :index, :update, :destroy]
end
