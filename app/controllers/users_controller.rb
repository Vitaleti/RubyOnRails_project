class UsersController < ApplicationController
  # Требуем аутентификацию для доступа к профилю
	before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]

	def show
    current_nickname = params[:nickname]
    @naming_convention = User.find_by(nickname: current_nickname)

    if @naming_convention && @naming_convention.email == current_user.email
      @user = current_user # Получаем информацию о текущем пользователе
      @posts = @user.posts # Получаем все посты текущего пользователя
      @following_count = @user.following.count # Количество подписок
      @followers_count = @user.followers.count # Количество подписчиков
    else
      redirect_to profile_path(current_user.nickname)
    end
  end

  def edit
    @user = User.find_by(nickname: params[:nickname])
  end

  def update
    @user = User.find_by(nickname: params[:nickname])
    if @user.update(user_params)
      redirect_to profile_path(@user.nickname), notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  def other_users
    @users = User.where.not(id: current_user.id)
  end

  def other_user
    nickname = params[:nickname]
    @naming_convention = User.find_by(nickname: nickname)

    if @naming_convention
      @user = @naming_convention
      @posts = @user.posts
      @following_count = @user.following.count
      @followers_count = @user.followers.count
    else
      redirect_to users_path, alert: "User not found"
    end
  end

  private

  def set_user
    @user = User.find_by(nickname: params[:nickname])
  end

  def user_params
    params.require(:user).permit(:name, :lastname, :nickname, :age, :avatar)
  end
end