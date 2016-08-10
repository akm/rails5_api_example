Rails.application.routes.draw do
  post    'sessions'     => 'sessions#create'
  delete  'sessions/:id' => 'sessions#destroy'

  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
end
