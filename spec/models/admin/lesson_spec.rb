require File.dirname(__FILE__) + '/../spec_helper'

describe Lesson do
  it "should be valid" do
    Lesson.new.should be_valid
  end
end
