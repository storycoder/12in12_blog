require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  test 'has a valid fixture' do 
  	@post = posts(:entry_one)
  	assert @post.valid?
  end

  should have_many(:comments)
  should validate_presence_of(:title)
  should validate_presence_of(:body)
end
