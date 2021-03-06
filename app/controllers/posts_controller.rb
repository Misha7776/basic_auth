class PostsController < ApplicationController
  before_action :logged_in_user
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new(user_id: params[:user_id])
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to user_posts_path(current_user), notice: 'Post was successfully created.'
    else
      render :new
    end
  end


  def update
    if @post.update(post_params)
      redirect_to user_posts_path(current_user), notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to user_posts_path(current_user), notice: 'Post was successfully destroyed.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body, :user_id, :title).merge(user_id: params[:user_id])
  end
end
