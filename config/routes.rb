require 'api_constraints'

GantabyaApi::Application.routes.draw do
  # Definition of Gantabya Rails Api
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api'}, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    end
  end
end
