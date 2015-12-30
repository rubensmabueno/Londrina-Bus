Rails.application.routes.draw do
  root 'home#index'

  namespace :api do
    namespace :v1 do
      resources :lines do
        resources :itineraries
        resources :positions

        resources :origins do
          resources :destinations do
            resources :schedules
          end
        end
      end
    end
  end
end
