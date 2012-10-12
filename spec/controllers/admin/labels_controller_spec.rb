require "spec_helper"

describe Admin::LabelsController do

  login_admin

  describe ".existing_suids" do

    context 'when no labels' do
      it "return empty result" do
        get :existing_suids
        response.should be_success
      end
    end

  end

end

