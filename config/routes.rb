Rails.application.routes.draw do
  resources :owners do
    resources :certificates
  end
end
