require "spec_helper"

describe Label do
  let(:label) { FactoryGirl.create(:label) }

  it "has a valid factory" do
    label.should be_valid
  end

  it "is invalid without a suid" do
    label.suid=nil
    label.should_not be_valid
  end

  it "is invalid when suid contains illegal characters" do
    label.suid = 'in w =='
    label.should_not be_valid
  end

  it "is invalid when suid is not in proper length" do
    label.suid = "in"
    label.should_not be_valid
    label.suid = "in_1_2_3_4_5_6_7_8_9_"
    label.should_not be_valid
  end

  let(:dictionary) { FactoryGirl.create(:dictionary) }

  it "is valid when suid is in proper length" do
    label.suid = "in_1_2_3_4_5_6_7_8_9"
    label.should be_valid
  end

  it "is assigned with default values" do
    label.fill_defaults(dictionary.id)
    label.suid.should start_with 'lbl_'
    label.dictionary.should eq(dictionary)
    label.label_descriptions.size.should eq Language.count
  end

  it "is valid using defaults" do
    label.fill_defaults(FactoryGirl.create(:dictionary).id)
    label.should be_valid
  end

  it "makes sure suid is lower case" do
    label.suid = "LABEL_1"
    label.save!
    label.suid.should eq "label_1"
  end

  it "returns suid when invoking to_s" do
    label.to_s.should eq label.suid
  end

  it "uses english description for display_name" do
    label.label_descriptions.by_language('ENG').update_all(text: "english description")
    label.display_name.should eq "english description"
  end

  context "Label#next_suid" do
    it "generates next suids correctly" do
      Label.next_suid.should eq 'lbl_1'
      label.suid='lbl_1'
      label.save!
      Label.next_suid.should eq 'lbl_2'
    end
  end

  context "Label#suid_starts_with" do
    it "return {} for blank prefix" do
      Label.suid_starts_with(' ').should be_empty
    end

    it "return only labels with suid starting with prefix" do
      FactoryGirl.create(:label)
      FactoryGirl.create(:label)
      FactoryGirl.create(:label)
      tmp_label = FactoryGirl.build(:label)
      tmp_label.suid = 'tmp_lbl_1'
      tmp_label.save!

      labels = Label.suid_starts_with('factory')
      labels.size.should eq 3
      labels.each do |lbl|
        lbl.suid.should start_with 'factory'
      end
    end
  end

end



