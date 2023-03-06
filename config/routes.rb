Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:index, :show, :create]
      resources :friendship, only: :index do
        collection do
          post 'follow'
          post 'unfollow'
          post 'decline_follow'
          post 'remove_follow'
          post 'accept_follow'
          get 'pending_requests'
          get 'follow_requests'
          get 'followers'
          get 'following'
        end
      end
      resources :activities, only: [:create] do
        collection do
          get 'lastest'
          get 'my_friend'
          get ':user_id' => 'activities#show', as: 'my'
        end
      end
      resources :clock_operations, only: [:index, :create]
    end
  end
end