class Api::V1::EventsController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]

  def index
    respond_with Event.all
  end

  def show
    respond_with Event.find(params[:id])
  end

  def create
    event = current_user.events.build(event_params)
    if event.save
      render json: event.without_image, status: 201
    else
      render json: { errors: event.errors }, status: 422
    end
  end

  def update
    event = current_user.events.find(params[:id])
    if event.update(event_params)
      render json: event, status: 200
    else
      render json: { errors: event.errors }, status: 422
    end
  end

  def destroy
    event = current_user.events.find(params[:id])
    event.destroy
    head 204
  end

  def image
    event = current_user.events.find(params[:id])
    event.image = params[:image]
    if event.save
      render json: event, status: 201
    else
      render json: { errors: event.errors }, status: 422
    end
  end

  private

    def event_params
      params.require(:event).permit(:name, :description, :organizer, :date)
    end

end
