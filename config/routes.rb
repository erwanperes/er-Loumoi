Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # get '/about' => 'pages#about'
  get 'pages/about', as: 'about'
   
  resources :users, only: [] do
    resources :items
  end
  
  resources :items do
    resources :reservations, only: [:new, :create]
    # Cela signifie que seules les routes new et create seront générées pour les réservations, dans le contexte d'un item spécifique.
  end
  
  # Cette section définit les routes pour les réservations, en dehors du contexte d'un item.
  resources :reservations, only: [:index, :show, :update, :destroy] do
    # Cela permet de définir des routes personnalisées pour les actions approve et reject, qui seront accessibles via des requêtes POST sur une réservation spécifique.
    member do
      post 'approve'
      post 'reject'
    end
  end
  
  
  # Route pour les erreurs 404
  match '/404', to: 'errors#not_found', via: :all
  
  # Rediriger toutes les autres routes non trouvées vers la page 404
  match '*path', to: 'errors#not_found', via: :all
end
