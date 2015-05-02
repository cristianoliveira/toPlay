require 'rails_helper'

RSpec.describe UserExerciseAnswersController, :type => :controller do


  let(:current_user) { FactoryGirl.create(:user) }

  describe "GET #create" do

    before :each do
      sign_in current_user
    end

    context 'user not logged' do
      before :each do
        sign_out
        get :create, { format: :json }
      end

      it{ expect(response.status).to eq 401 }
      it{ expect(response.content_type).to be_include 'application/json' }
      it{ expect(response.body).to be_include 'error' }
    end

    context 'user logged' do
      it "returns http success" do
        # given
        alternative = FactoryGirl.create(:alternative, correct: true)
        answer = FactoryGirl.build(:user_exercise_answer, alternative: alternative)
        params = answer.attributes

        # when
        get :create, { :user_exercise_answer => params ,format: :json }

        # then
        expect(response).to be_success
      end
    end

    context 'when answer is correct' do
      it 'should score return ' do
        # given
        alternative = FactoryGirl.create(:alternative, correct: true)
        answer = FactoryGirl.build(:user_exercise_answer, alternative: alternative)
        params = answer.attributes
        expected = current_user.points + 100

        # when
        get :create, { user_exercise_answer: params, format: :json }

        # then
        expect(response.body).to include '"is_correct_answer":true'
      end

      it 'should score +100 points' do
        # given
        alternative = FactoryGirl.create(:alternative, correct: true)
        answer = FactoryGirl.build(:user_exercise_answer, alternative: alternative)
        params = answer.attributes
        expected = current_user.points + 100

        # when
        get :create, { user_exercise_answer: params, format: :json }

        # then
        expect(current_user.points).to be_eql expected
      end
    end

    context 'when answer is incorrect' do
      it 'should score return ' do
        # given
        alternative = FactoryGirl.create(:alternative, correct: false)
        answer = FactoryGirl.build(:user_exercise_answer, alternative: alternative)
        params = answer.attributes
        expected = current_user.points + 100

        # when
        get :create, { user_exercise_answer: params, format: :json }

        # then
        expect(response.body).to include '"is_correct_answer":false'
      end

      it 'should score +50 points' do
        # given
        alternative = FactoryGirl.create(:alternative, correct: false)
        answer = FactoryGirl.build(:user_exercise_answer, alternative: alternative)
        params = answer.attributes
        expected = current_user.points + 50

        # when
        get :create, { user_exercise_answer: params, format: :json }

        # then
        expect(current_user.points).to be_eql expected
      end
    end
  end
end
