class Api::V1::EventsController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!, only: [:create]

  def index
    respond_with Event.all
  end

  def show
    respond_with Event.find(params[:id])
  end

  def create
    event = current_user.events.build(event_params)
    if event.save
      render json: event, status: 201
    else
      render json: {errors: event.errors}, status: 422
    end
  end

  private

    def event_params
      params.require(:event).permit(:name, :description, :organizer, :date, :image_link)
    end
end
