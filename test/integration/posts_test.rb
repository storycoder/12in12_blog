require 'test_helper'

class PostsTest < ActionDispatch::IntegrationTest
  
  def setup
  	@entry_one = posts(:entry_one)

  	visit posts_path

  end

  	test 'sidebar has all content & links' do 
  		assert page.has_content?('Website')
  		click_link('Blog')
  		click_link('About')

  		assert page.has_content?('Social')
  		assert page.has_link?('Twitter', href: 'https://twitter.com/josephmargolis')
  		assert page.has_link?('Instagram', href: 'http://instagram.com/josephmargolis')
  		assert page.has_link?('Github', href: 'https://github.com/storycoder')
  		assert page.has_link?('Email', href: 'mailto:joseph.margolis@gmail.com')

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
		assert page.has_link?(@entry_one.title)

		# binding.pry;
		assert page.find('.body').text.length <= 265


		# find('p', @entry_one.body.length <= 250) #I wrote this to test the function that limits no. of chars of per post seen by user on index to be no more that 250, but now I believe this test only provides length of entire text. NEEDS MORE WORK!!
		
		assert has_link?('READ MORE', @entry_one ) #This is edited to account for post_path being same as @entry_one in the fixture/setup - Still need a test for max # of characters. 
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
