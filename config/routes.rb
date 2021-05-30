Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :dealers, only: [:index]
    end
  end
end
