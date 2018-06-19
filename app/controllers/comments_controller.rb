class CommentsController < ApplicationController
  def index
    @comments = Comment.all
    @ability = Ability.new(current_user)
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    
    if @comment.save
      respond_to do |format|
        format.html do
          redirect_to post_path(@post)
        end
        format.js
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @ability = Ability.new(current_user)

    @comment.destroy
    respond_to do |format|
      format.html do
        render @post
      end
      format.js
    end
  end
  
  private

  def comment_params
    params.require(:comment).permit(:title, :body, :user_id)
  end
end
