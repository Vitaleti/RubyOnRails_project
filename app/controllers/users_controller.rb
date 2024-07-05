class UsersController < ApplicationController
  # Требуем аутентификацию для доступа к профилю
	before_action :authenticate_user!

	def show
		@user = current_user
	end
end