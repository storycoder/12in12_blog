class PostsController < ApplicationController

	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)

		if @post.save
			redirect_to @post, notice: 'Post created successfully'
		else
			render :new
		end
	end

	private

		def post_param
			params.require(:post).permit(:title, :body)
		end

end
