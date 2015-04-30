require 'rails_helper'

RSpec.describe SearchController, :type => :controller do

  describe "GET index" do

    context 'user not logged' do
      it 'should redirect to sign_in' do
        get :index, { q: "some" }

        expect(response).to be_redirect
      end
    end

    context 'user logged' do
      it "returns http success" do
        sign_in
        get :index, { q: "some" }
        expect(response).to be_success
      end
    end

  end

end
