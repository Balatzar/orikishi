Rails.application.routes.draw do
  get '/:story', to: 'orikishi#index'
  post '/:story/add_follow_up', to: 'orikishi#add_follow_up'
end
