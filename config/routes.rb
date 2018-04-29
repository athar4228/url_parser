Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      jsonapi_resources :url_responses, only: [:index, :create]
    end
  end
end
