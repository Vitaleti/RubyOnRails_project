class UsersController < ApplicationController
  # Требуем аутентификацию для доступа к профилю
	before_action :authenticate_user!

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

  def other_users
    @users = User.where.not(id: current_user.id)
  end

  def other_user
    nickname = params[:nickname]
    @naming_convention = User.find_by(nickname: nickname)

    if @naming_convention
      @user = @naming_convention
    else
      redirect_to users_path, alert: "User not found"
    end
  end
end