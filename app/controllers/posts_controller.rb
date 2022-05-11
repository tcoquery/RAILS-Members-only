class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
  end


  def new
    @post = Post.new
  end

  def create
    @post = Post.new(body: params[:body])

    if @post.save
      flash[:success] = "Great! Your post has been created!"
      redirect_to @post
    else
      flash.now[:error] = "Rats! Fix your mistakes, please."
      render :new, status: :unprocessable_entity
    end
  end


  private

  def require_login
    unless user_signed_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_user_session_path # halts request cycle
    end
  end
end
