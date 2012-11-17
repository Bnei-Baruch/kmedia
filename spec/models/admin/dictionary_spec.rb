require "spec_helper"

describe Dictionary do
  let(:dictionary) { FactoryGirl.create(:dictionary) }

  it "has a valid factory" do
    dictionary.should be_valid
  end

  it "is invalid without a suid" do
    dictionary.suid=nil
    dictionary.should_not be_valid
  end

  it "is invalid when suid contains illegal characters" do
    dictionary.suid = 'in w =='
    dictionary.should_not be_valid
  end

  it "is invalid when suid is not in proper length" do
    dictionary.suid = "in"
    dictionary.should_not be_valid
    dictionary.suid = "in_1_2_3_4_5_6_7_8_9_"
    dictionary.should_not be_valid
  end

  it "is valid when suid is in proper length" do
    dictionary.suid = "in_1_2_3_4_5_6_7_8_9"
    dictionary.should be_valid
  end

  it "is assigned with default values" do
    dictionary.fill_defaults
    dictionary.suid.should start_with 'dict_'
    dictionary.dictionary_descriptions.size.should eq Language.count
  end

  it "is valid using defaults" do
    dictionary.fill_defaults
    dictionary.should be_valid
  end

  it "makes sure suid is lower case" do
    dictionary.suid = "DICTIONARY_1"
    dictionary.save!
    dictionary.suid.should eq "dictionary_1"
  end

  it "returns suid when invoking to_s" do
    dictionary.to_s.should eq dictionary.suid
  end

  context "Dictionary#next_suid" do
    it "generates next suids correctly" do
      Dictionary.next_suid.should eq 'dict_1'
      dictionary.suid='dict_1'
      dictionary.save!
      Dictionary.next_suid.should eq 'dict_2'
    end
  end

  context "Dictionary#suid_starts_with" do
    it "return {} for blank prefix" do
      Dictionary.suid_starts_with(' ').should be_empty
    end

    it "return only dictionaries with suid starting with prefix" do
      FactoryGirl.create(:dictionary)
      FactoryGirl.create(:dictionary)
      FactoryGirl.create(:dictionary)
      tmp_dictionary = FactoryGirl.build(:dictionary)
      tmp_dictionary.suid = 'tmp_dict_1'
      tmp_dictionary.save!

      dictionaries = Dictionary.suid_starts_with('factory')
      dictionaries.size.should eq 3
      dictionaries.each do |dict|
        dict.suid.should start_with 'factory'
      end
    end
  end

end



