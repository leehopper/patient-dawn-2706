Rails.application.routes.draw do
  # resources :competitions, only: [:index, :show]

  resources :competitions, only: [:index, :show] do
    resources :teams, only: [:new, :create], controller: 'competition_teams'
  end
end
