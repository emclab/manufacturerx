Manufacturerx::Engine.routes.draw do
  resources :manufacturers do
    collection do
      get :search
      get :search_results
      get :autocomplete
    end
  end
  
  root :to => 'manufacturers#index'

end
