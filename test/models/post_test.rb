require 'test_helper'

class PostTest < ActiveSupport::TestCase
  should validate_presence_of(:title)
  should validate_presence_of(:body)
end
