require File.dirname(__FILE__) + '/../../spec_helper'

describe Label do
  before { @label = Label.new }

  subject {@label}

  context "when suid empty" do
    it { should_not be_valid }
    it {should have_a_}
    specify { @label.save.should == false }
  end

  context "when suid has value" do
    before { @label.suid = 'lbl' }
    it { should_not be_valid }
    specify { @label.save.should == false }
  end

  context "when suid and dictionary has values" do

  end

  context "should return english description as display_name" do
    #label = Label.new(label_descriptions: [LabelDescription.new(lang: 'ENG', text: 'english')])
    #label.display_name.should eq('english')
  end

  describe "Persistence behavior" do

    it "downcase suid before save" do
      dictionary = Dictionary.create!(suid:'dict')
      label = Label.new(suid: 'LbL_1')
      label.dictionary = dictionary
      label.save!
      dbLabel = Label.find_by_suid('lBl_1')
      dbLabel.should
      dbLabel.suid.should eq('lbl_1')
    end
  end
end



