SampleApp::Application.routes.draw do
  get "activities/show"
  get "actions/new"
    resources :users
    resources :sessions,    only: [:new, :create, :destroy] # index, edit, update, show
    resources :actions,     only: [:create, :destroy]
    resources :activities,  only: [:create, :destroy, :update, :new]
    root  'static_pages#home'
    get 'こんにちは', to: 'static_pages#help' #fuckin cool
    match '/help',		to: 'static_pages#help',    via: 'get'
    match '/about', 	to: 'static_pages#about',   via: 'get'
    match '/contact',	to: 'static_pages#contact', via: 'get'
    match '/signup', 	to: 'users#new',			via: 'get'
    match '/signin',	to: 'sessions#new',			via: 'get'
    match '/signout', 	to: 'sessions#destroy',		via: 'delete'
end
