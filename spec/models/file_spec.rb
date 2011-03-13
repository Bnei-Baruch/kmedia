require File.dirname(__FILE__) + '/../spec_helper'

describe Asset do
  it "should be valid" do
    Asset.new.should be_valid
  end
end
