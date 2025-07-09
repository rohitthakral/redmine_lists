Rails.application.routes.draw do
  # resources :projects do
  #   resources :lists do
  #     resources :list_items, except: [:show]
  #   end
  # end
  resources :lists
  match 'lists/:project_id/settings/update', to: "projects_lists#settings_update", as: "projects_lists_settings_update", via: [:post]
  match 'lists/:project_id/create/:list_id', to: "projects_lists#create", as: "projects_lists_create", via: [:post]
  match 'lists/:project_id/update/:list_id', to: "projects_lists#update", as: "projects_lists_update", via: [:post]
  match 'lists/:project_id/index/:list_id', to: "projects_lists#index", as: "projects_lists", via: [:get]
  match 'lists/:project_id/new/:list_id', to: "projects_lists#new", as: "projects_lists_new", via: [:get]
  match 'lists/:project_id/edit/:list_id', to: "projects_lists#edit", as: "projects_lists_edit", via: [:get]
  match 'lists/:project_id/destroy/:list_id', to: "projects_lists#destroy", as: "projects_lists_destroy", via: [:delete]
  match 'lists/:list_id/custom_field', to: "lists#custom_field", as: "lists_custom_field", via: :post
end
