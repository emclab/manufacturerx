Manufacturerx::Engine.routes.draw do
  resources :manufacturers
  
  root :to => 'manufacturers#index'

end
