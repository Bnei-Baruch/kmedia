require File.dirname(__FILE__) + '/../spec_helper'

describe LessondescPattern do
  it "should be valid" do
    LessondescPattern.new.should be_valid
  end
end
