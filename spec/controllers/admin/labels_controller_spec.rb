require 'spec_helper'

describe Admin::LabelsController do

  it "list assignable labels" do
    label = Label.create(suid: 'lbl')
    get :assignable
    expect(assigns(:labels)).to eq([widget])

  end
end