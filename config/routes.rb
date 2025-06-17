Rails.application.routes.draw do
  resources :projects do
    resources :lists do
      resources :list_items, except: [:show]
    end
  end
end
