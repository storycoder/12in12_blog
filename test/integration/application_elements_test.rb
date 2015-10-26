require 'test_helper'

class ApplicationElementsTest < ActionDispatch::IntegrationTest
	def setup
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

	assert page.has_text?('Admin Login')
  	end

  	test 'header shows all content and clicks all buttons' do 
  		assert page.has_content?('All Posts')
  		click_button 'New Post'
  		click_button 'Log Out'
  	end
end
