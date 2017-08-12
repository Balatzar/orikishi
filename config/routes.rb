Rails.application.routes.draw do
  get '/', to: 'public#index'
  get '/:story', to: 'public#orikishi'
  post '/:story/add_follow_up', to: 'public#add_follow_up'

  resources :story, only: ["new", "create"]
end
