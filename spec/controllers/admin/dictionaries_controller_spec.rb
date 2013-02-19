require "spec_helper"

describe Admin::DictionariesController do
  render_views

  context "as admin" do
    login_admin

    describe "GET index" do
      before(:each) do
        @dictionaries = [FactoryGirl.create(:dictionary)]
        get :index
      end

      it "assigns @dictionaries" do
        should assign_to(:dictionaries).with(@dictionaries)
      end

      it "renders the index template" do
        should render_template :index
      end

      it "is successful" do
        should respond_with(:success)
      end

      it "doesn't set the flash" do
        should_not set_the_flash
      end
    end

    describe  "GET show" do
      before(:each) do
        @dictionary = FactoryGirl.create(:dictionary)
        get :show, { id: @dictionary.id  }
      end

      it "assigns @dictionary" do
        should assign_to(:dictionary).with(@dictionary)
      end

      it "assigns @descriptions" do
        should assign_to(:descriptions).with(@dictionary.dictionary_descriptions)
      end

      it "renders the show template" do
        should render_template :show
      end

      it "is successful" do
        should respond_with(:success)
      end

      it "doesn't set the flash" do
        should_not set_the_flash
      end
    end
  end

end

