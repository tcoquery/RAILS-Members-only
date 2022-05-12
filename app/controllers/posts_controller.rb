class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @post = Post.all.includes(:user)
  end


  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.new(user_params)

    if @post.save
      flash[:success] = "Great! Your post has been created!"
      redirect_to posts_url
    else
      flash.now[:error] = "Rats! Fix your mistakes, please."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:post).permit(:body, :user_id)
  end

  def require_login
    unless user_signed_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_user_session_path # halts request cycle
    end
  end
end
