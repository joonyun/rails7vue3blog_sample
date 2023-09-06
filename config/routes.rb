Rails.application.routes.draw do
  root 'main#index'

  resources :main, except: [:show] 

  get "main/chat", to: "main#chat"
  get "main/channel", to: "main#channel"

  namespace :api, :defaults => { :format => 'json' } do
    resources :main, except: [:edit, :new]
  end

end
