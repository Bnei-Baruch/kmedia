require 'minitest_helper'

describe User do
  should belong_to :department
  should have_and_belong_to_many(:roles)
  should have_many :containers
  should have_many :container_description_patterns
  should have_many :catalogs
  should have_many :file_assets
  should have_many :virtual_lessons


  describe 'gregory exists' do
    it 'really exists' do
      gregory = FactoryGirl.build_stubbed(:gregory)
      assert_equal('gshilin@gmail.com', gregory.email)
    end
  end
end

