require 'test_helper'

class CategoryDescriptionTest < ActiveSupport::TestCase
  test "category description validation" do
    desc = CategoryDescription.new
    assert(desc.valid?, "")
  end
end
