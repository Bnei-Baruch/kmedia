require 'minitest_helper'

describe HomeHelper do
  describe 'is_active_pager' do
    it 'active' do
      assert_equal 'active', is_active_pager("11", "11")
    end

    it 'non-active' do
      assert_equal 'non-active', is_active_pager("11", "12")
    end
  end
end

