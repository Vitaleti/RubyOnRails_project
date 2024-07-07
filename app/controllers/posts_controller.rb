class PostsController < ApplicationController
	def index
		current_nickname = params[:nickname]
		if current_nickname == current_user.nickname
			@posts = Post.all
		else
			redirect_to profile_path(current_user.nickname), alert: "User not found"
		end
	end
end