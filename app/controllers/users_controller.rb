class UsersController < ApplicationController
  # Требуем аутентификацию для доступа к профилю
	before_action :authenticate_user!

	def show
    current_nickname = params[:nickname]
    @naming_convention = User.find_by(nickname: current_nickname)
    if @naming_convention && @naming_convention.email == current_user.email
      @user = current_user
      @posts = @user.posts # Получаем все посты текущего пользователя
    else
      redirect_to profile_path(current_user.nickname), alert: "User not found"
    end
  end

  def other_users
    @users = User.all
  end
end