Rails.application.routes.draw do

  root :to => "main#index"

  resource :user
  resource :session
  resources :contacts

end
