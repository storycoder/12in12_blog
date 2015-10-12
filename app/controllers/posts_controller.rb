class PostsController < ApplicationController

	def index
		@posts = Post.all
	end

	def show
		@post = Post.find(params[:id])
	end

	def new
		@post = Post.new
	end

	def edit
		@post = Post.find(params[:id])
	end

	def create
		@post = Post.new(post_params)

		if @post.save
			redirect_to @post, notice: 'Post created successfully'
		else
			render :new
		end
	end

	def update
		@post = Post.find(params[:id])

		if @post.update(post_params)
			redirect_to @post, notice: 'Event updated successfully'
		else
			render :edit
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_url, notice: 'Post deleted successfully'
	end

	private

		def post_params
			params.require(:post).permit(:title, :body)
		end

end
