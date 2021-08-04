Rails.application.routes.draw do
  resources :competitions, only: [:index, :show]
end
