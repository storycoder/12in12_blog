require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  
  def setup
    @post = posts(:entry_one)
  end

  test "should get index" do 
  	get :index
  	assert_response :success
  	assert_not_nil assigns(:posts)
  end

  test "should show post" do
    get :show, id: @post.id
    assert_response :success
  end

  test "should get new" do 
  	get :new
  	assert_response :success
  	assert_not_nil assigns(:post)
  end

  test "should post create" do 
    assert_difference('Post.count') do 
      post :create, post: {title: 'My Post', body: 'Some ipsum'}
    end

    assert_redirected_to post_path(assigns(:post))
  end

  #i created the show and create tests after making the controller. The following tests are prior to creating the action.

  test "should get edit" do 
    get :edit, id: @post.id
    assert_response :success
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post.id
    end
 
    assert_redirected_to posts_path
  end

  #update test has errors
  test "should update post" do 
    assert_no_difference('Post.count') do 
      put :update, id: @post.id, post: {title: 'My Post', body: 'Updated Ipsum'}
    end

    assert_redirected_to post_path(assigns(:post))
  end

end