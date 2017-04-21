class UsersController < ApplicationController
  # json ---
  def show
    user = User.find(params[:id])
    articles = user.articles.with_month(params[:month], time_zone: time_zone)
    render json: UserRepresentation.new(user, articles: articles)
  end

  def current
    render json: AuthenticatedUserRepresentation.new(current_user)
  end

  # html ---
  def new
    invitation = Invitation.find_with_valid_token(params[:token])
    redirect_to login_path and return if invitation.blank?

    @token = invitation.token
    @user = User.new({email: invitation.email})
  end

  def create
    invitation = Invitation.find_with_valid_token(params[:invitation_token])
    redirect_to login_path and return if invitation.blank?

    user_attrs = username_params.to_h.reverse_merge({ email: invitation.email })
    @user = User.new(user_attrs)
    if @user.save
      login(@user)
      redirect_to root_path
    else
      @token = invitation.token
      render :new
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    user_attrs = user_params
    if @user.update_attributes(user_attrs)
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
