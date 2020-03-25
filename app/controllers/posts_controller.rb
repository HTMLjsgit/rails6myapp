class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :update, :destroy, :edit]
	before_action :post_find, only: [:edit, :show, :update, :destroy]
	before_action :is_mine, only: [:edit, :update, :destroy]
  def index
  	@posts = Post.all
  end

  def show
  end

  def new
  	@post = Post.new
  end

  def edit
  end

  def create
  	@post = Post.new(create_params)
	@post.user_id = current_user.id
  	@post.save
  	redirect_to root_path
  end

  def update
  	@post.update(create_params)
  	redirect_to root_path
  end

  def destroy
  	@post.destroy
  	redirect_to root_path
  end

  private
  	def post_find
  		@post = Post.find params[:id]
  	end

  	def create_params
  		params.require(:post).permit(:title, :body)
	end

	def is_mine
		if @post.user_id != current_user.id
			redirect_to root_path
		end
	end
end
