require 'rails_helper'

RSpec.describe UserExerciseAnswersController, :type => :controller do

  let(:exercise){ FactoryGirl.create(:exercise) }
  let(:user){ FactoryGirl.create(:user) }
  let(:alternative){ FactoryGirl.create(:alternative) }

  let(:params) { { :user_id => user.id,
                   :exercise_id => exercise.id,
                   :alternative_id => alternative.id } }
                   
  describe "GET #create" do
    context 'user not logged' do
      before :each do
        get :create, { format: :json }
      end

      it{ expect(response.status).to eq 401 }
      it{ expect(response.content_type).to be_include 'application/json' }
      it{ expect(response.body).to be_include 'error' }
    end

    context 'user logged' do
      it "returns http success" do
        sign_in



        get :create, { :user_exercise_answer => params ,format: :json }
        expect(response).to be_success
      end
    end

  end

end
