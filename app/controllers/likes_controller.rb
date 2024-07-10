class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post

  def create
    @post.likes.create(user: current_user)
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @post.likes.find_by(user: current_user).destroy
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end
end