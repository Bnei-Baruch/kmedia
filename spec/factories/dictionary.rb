FactoryGirl.define do
  sequence :dictionary_suid do |n|
    "factory_dict_#{n}"
  end

  sequence :dictionary_description_gen do |n|
    "dictionary description #{n}"
  end

  factory :dictionary, class: Dictionary do
    suid {generate(:dictionary_suid)}
    dictionary_descriptions { [create(:dictionary_description)] }
  end

  factory :dictionary_description, class: DictionaryDescription do
    language {Language.find_by_code3('ENG')}
    topic { generate(:dictionary_description_gen) }
  end

end