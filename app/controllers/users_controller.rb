class UsersController < ApplicationController
  # Требуем аутентификацию для доступа к профилю
	before_action :authenticate_user!

	def show
    sanitized_nickname = params[:nickname]
    @naming_convention = User.find_by(nickname: sanitized_nickname)
    if @naming_convention
      @user = current_user
      @posts = @user.posts # Получаем все посты текущего пользователя
    else
      redirect_to root_path, alert: "User not found"
    end
  end
end