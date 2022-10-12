Rails.application.routes.draw do
  resources :inventories
  devise_for :users
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end
  resources :recipes, only: [:index, :new, :create, :show, :destroy] do
    resources :recipe_foods, only: [:create, :destroy]
  end
  resources :inventories, only: [:index, :new, :create, :show, :destroy] do
    resources :inventory_foods, only: [:create, :destroy]
  end
  resources :foods, only: [:index, :new, :create, :destroy]

  get '/public_recipes', to: 'recipes#list_public'

  root "foods#index"
end
