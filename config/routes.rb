Rails.application.routes.draw do
  get '/:story', to: 'orikishi#index'
end
