class PostsController < ApplicationController
  
  def index
    @posts = Post.all

    @ability = Ability.new(current_user)
  end 

  def new
    @post = Post.new(user_id: current_user.id)
    @post.images.build
  end
  
  def show
    @post = Post.find(params[:id])

    @ability = Ability.new(current_user)
  end

  def create
    @post = current_user.posts.create(post_params)

    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @ability = Ability.new(current_user)
    
    if @post.update(post_params)
      redirect_to do |format|
        format.html do
          redirect_to posts_path
        end
        format.js
      end
    else
      render 'edit'
    end
  end

  def destroy
    
    user = Post.find(params[:id]).user
    @ability = Ability.new(current_user)
     
    @post = user.posts.find(params[:id])
    if @post.destroy
      @posts = Post.all
      respond_to do |format|
        format.html do
          redirect_to posts_path
        end
        format.js
      end
    end
  end

  def approve
    @post = Post.find(params[:id])
    @posts = Post.all
    @ability = Ability.new(current_user)
    #byebug
    @post.update_columns(publish: true) if !@post.publish
    respond_to do |format|
      format.html do 
        redirect_to posts_path
      end
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :publish, :published_at, :user_id, images_attributes: [:id, :name, :_destroy])
  end
end
