Rails.application.routes.draw do
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

  resources :inventory_foods, only: [:new, :show, :create, :destroy]
    # post 'shopping_list/:recipe_id', to: 'shopping_lists#generate'
  # end
  post 'inventory_foods/:id/create', to: 'inventory_foods#create'
  get 'inventory_foods/:id/new', to: 'inventory_foods#new'

  get '/public_recipes', to: 'recipes#list_public'

  root "recipes#index"
end
