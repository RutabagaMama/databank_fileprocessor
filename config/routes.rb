Rails.application.routes.draw do
  resources :problems
  resources :message_outs
  resources :message_ins
  resources :nested_items
  resources :peeks
  resources :tasks
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
