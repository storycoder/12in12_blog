require 'test_helper'

class PostsTest < ActionDispatch::IntegrationTest
  
  def setup
  	@entry_one = posts(:entry_one)
  	@entry_two = posts(:entry_two)

  	visit posts_path

  end

  	test 'sidebar shows all content & clicks all links' do 
  		assert page.has_content?('Website')
  		click_link('Blog')
  		click_link('About')

  		assert page.has_content?('Social')
  		# click_link('Twitter').observable_redirect_to('https://twitter.com/josephmargolis')
  		# click_link('')
  		# click_link('')
  		# click_link('')

#I need to find a DRY way to test for functional external links to urls and email.

  		assert page.has_content?('Admin Login')
  	end

  	test 'header shows all content and clicks all buttons' do 
  		assert page.has_content?('All Posts')
  		click_button 'New Post'
  		click_button 'Log Out'
  	end
  		

	test 'Index page shows all posts' do 
		assert page.has_content?('Posts')

		assert page.has_content?(@entry_one.title)
		assert page.has_content?(@entry_one.body)

		assert page.has_content?(@entry_two.title)
		assert page.has_content?(@entry_two.body)

	end

	test 'show page shows post' do
		click_link(@entry_one.title)
		assert page.has_content?(@entry_one.title)
		assert page.has_content?(@entry_one.body)
		#need a test for time_ago_in_words
		click_link('Edit Post')
		click_link('Back')
		click_link('Delete')
	end

	test 'Can create posts' do 

		click_link('Create Post')

		fill_in 'Title', with: 'My Blog Entry'
		fill_in 'Body', with: 'My ipsum is your ipsum'

		click_button 'Create Post'

		assert page.has_content?('My Blog Entry')
		assert page.has_content?('My ipsum is your ipsum')
	end

	test 'Can update posts' do
		click_link @entry_one.title
		click_link('Edit Post')

		fill_in 'Title', with: 'My Blog edit'
		fill_in 'Body', with: 'My test ipsum is your test ipsum'

		click_button 'Update Post'

		assert page.has_content?('My Blog edit')
		assert page.has_content?('My test ipsum is your test ipsum')
	end

	test 'Can destroy posts' do
		click_link @entry_one.title
		click_link('Delete Post')

		refute page.has_content?(@entry_one.title)
		refute page.has_content?(@entry_one.body)
	end

end
