class BoardsController < ApplicationController
  def home
    render :index
  end

  def index
    users = User.find_current
    render json: users.map { |u| BoardRepresentation.new(u) }
  end
end
