require 'api_constraints'

GantabyaApi::Application.routes.draw do
  devise_for :users, skip: [:registrations]
  # Definition of Gantabya Rails Api
  namespace :api, defaults: { format: :json }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]
      resources :events, :only => [:index, :show, :create, :update]
    end
  end
end

