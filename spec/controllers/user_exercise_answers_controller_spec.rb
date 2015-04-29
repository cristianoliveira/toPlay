require 'rails_helper'

RSpec.describe UserExerciseAnswersController, :type => :controller do

  describe "GET #create" do
    context 'user not logged' do
      it 'should redirect to sign_in' do
        get :create

        expect(response).to be_redirect
      end
    end

    context 'user logged' do
      it "returns http success" do
        sign_id
        get :create
        expect(response).to be_success
      end
    end

  end

end
