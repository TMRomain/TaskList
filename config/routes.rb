Rails.application.routes.draw do
  resources :home, only: [:create]
  delete 'home/delete/:id', to: 'home#delete', as: 'delete_task'
  post 'home/changeState/:id', to: 'home#changeState', as: 'changeState_task'
  post 'home/updateSelection/:selection', to: 'home#updateSelection', as: 'update_selection'
  
  post 'home/redirectToUpdate/:id', to: 'home#redirectToUpdate', as: 'update_task'

  patch 'home/nextMonth', to: 'home#nextMonth'
  patch 'home/previousMonth', to: 'home#previousMonth', as: 'previousMonth'
  
  # get 'home/index'
  get 'home/addTask'
  get 'home/updateTask'
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
