class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to post_path(@post), alert: 'Comment could not be created' }
        format.turbo_stream
      end
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      respond_to do |format|
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to post_path(@post), alert: 'You can only delete your own comments' }
        format.turbo_stream
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end