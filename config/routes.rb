Rails.application.routes.draw do
  get '/', to: 'public#index'

  resources :stories, only: ["new", "create"]
  resources :surveys do
    resources :participations, only: ["create"]
  end

  # MUST BE AFTER EVERYTHING
  get '/:story', to: 'public#orikishi'
  post '/:story/add_follow_up', to: 'public#add_follow_up'
end
