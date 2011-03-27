require File.dirname(__FILE__) + '/../spec_helper'

describe Catalog do
  it "should be valid" do
    Catalog.new.should be_valid
  end
end
