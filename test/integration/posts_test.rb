require 'test_helper'

class PostsTest < ActionDispatch::IntegrationTest
  
  def setup
  	@entry_one = posts(:entry_one)
  	@entry_two = posts(:entry_two)

  	visit posts_path

  end

test 'Index page shows all posts' do 
	assert page.has_content?('Posts')

	assert page.has_content?(@entry_one.title)
	assert page.has_content?(@entry_one.body)

	assert page.has_content?(@entry_two.title)
	assert page.has_content?(@entry_two.body)

end

test 'Can create posts' do 

	click_link('Create Post')

	fill_in 'Title', with: 'My Blog Entry'
	fill_in 'Body', with: 'My ipsum is your ipsum'

	click_button 'Create Post'

	assert page.has_content?('My Blog Entry')
	assert page.has_content?('My ipsum is your ipsum')
end

end
