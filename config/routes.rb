Rails.application.routes.draw do
  scope format: false do
    resources :owners do
      resources :certificates
    end
  end
end
