FactoryGirl.define do
  sequence :label_suid do |n|
    "factory_lbl_#{n}"
  end

  sequence :label_description_gen do |n|
    "label description #{n}"
  end

  factory :label, class: Label do
    suid {generate(:label_suid)}
    dictionary
    label_descriptions { [create(:label_description)] }
  end

  factory :label_description, class: LabelDescription do
      language {Language.find_by_code3('ENG')}
      text { generate(:label_description_gen) }
  end

end