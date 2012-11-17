require "spec_helper"

describe Admin::DictionariesController do

  describe "as operator" do
    it "index action should assign @dictionaries" do
      get :index
      assigns(:dictionaries)
    end

  end

  # still an empty test [WIP]

end

