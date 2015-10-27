require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def setup
  		@post = posts(:entry_one)
  		@comment = comments(:comment_one)
  end


  test 'should create comments' do
  	
  	assert_difference('Comment.count', +1) do 
      post :create, comment: {name: 'joe smith', comment_body: 'Comment Ipsum', post_id: 1}
    end
  end
end
