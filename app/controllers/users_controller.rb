class UsersController < ApplicationController
  include Kagishi

  # json ---
  def show
    user = User.find(params[:id])
    articles = user.articles.with_month(params[:month], time_zone: preferred_time_zone)
    render json: UserRepresentation.new(user, articles: articles)
  end

  def current
    render json: AuthenticatedUserRepresentation.new(current_user)
  end

  # html ---
  def new
    payload = payload(params[:token])
    redirect_to login_path and return if payload.blank?

    @token = params[:token]
    @user = User.new({email: payload.email})
  end

  def create
    payload = payload(params[:invitation_token])
    redirect_to login_path and return if payload.blank?

    @user = User.new(username_params.merge({ email: payload.email }))
    if @user.save
      login(@user)
      redirect_to root_path
    else
      @token = params[:invitation_token]
      render :new
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

    def username_params
      params.require(:user).permit(:username, :time_zone)
    end

    def user_params
      params.require(:user).permit(:name, :bio, :time_zone)
    end
end
