class Api::V1::EventsController < ApplicationController
  respond_to :json

  def index
    respond_with Event.all
  end

  def show
    respond_with Event.find(params[:id])
  end
end
