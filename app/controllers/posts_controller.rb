class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy, :show]

  def destroy
    if params[:nickname] == current_user.nickname
      if @post.user_id == current_user.id
        @post.destroy
        redirect_to profile_path(current_user.nickname), alert: "Post deleted successfully"
      else
        redirect_to profile_path(current_user.nickname)
      end
    else
      redirect_to profile_path(current_user.nickname), alert: "User not found"
    end
  end

  def edit
    current_nickname = params[:nickname]
    if current_nickname == current_user.nickname
      # @post уже установлен в before_action
    else
      redirect_to profile_path(current_user.nickname), alert: "User not found"
    end
  end

  def index
    current_nickname = params[:nickname]
    if current_nickname == current_user.nickname
      subscribed_users_ids = current_user.following.pluck(:id)
      @posts = Post.where(user_id: subscribed_users_ids)
    else
      redirect_to profile_path(current_user.nickname), alert: "User not found"
    end
  end

  def new
    current_nickname = params[:nickname]
    if current_nickname == current_user.nickname
      @post = Post.new
    else
      redirect_to profile_path(current_user.nickname), alert: "User not found"
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to profile_path(current_user.nickname), notice: "Post created successfully"
    else
      render :new
    end
  end

  def update
    current_nickname = params[:nickname]
    if current_nickname == current_user.nickname
      if @post.update(post_params)
        redirect_to profile_path(current_user.nickname), notice: "Post updated successfully"
      else
        render :edit
      end
    else
      redirect_to profile_path(current_user.nickname), alert: "User no"
    end
  end

  def show
    # @post уже установлен в before_action
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end