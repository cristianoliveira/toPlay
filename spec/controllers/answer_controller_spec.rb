require 'rails_helper'

RSpec.describe AnswerController, :type => :controller do

  let(:exercise){ FactoryGirl.create(:exercise) }
  let(:correct){ FactoryGirl.create(:alternative) }
  let(:incorrect){ FactoryGirl.create(:alternative_incorrect) }

  describe "GET #get_answer" do

    context 'user not logged' do
      it 'should redirect user' do
        sign_out
        get :get_answer, { answer_id: correct.id , format: :json }

        expect(response.status).to eq 401
      end
    end

    context 'when request html' do
      it {
        expect{
          sign_in
          get :get_answer, { exercise_id: exercise.id, answer_id: correct.id }
        }.to raise_error ActionController::UnknownFormat
      }
    end

    context 'when given a correct answer' do
      before :each do
        sign_in
        correct.correct = true
        correct.save
        get :get_answer, { answer_id: correct.id , format: :json }
      end

      it{ expect(response).to be_success }
      it{ expect(response.content_type).to be_eql 'application/json' }
      it{ expect(response.body).to be_include '"is_correct":true' }

    end

    context 'when given a incorrect answer' do
      before :each do
        sign_in
        incorrect.correct = false
        incorrect.save
        get :get_answer, { answer_id: incorrect.id , format: :json }
      end

      it{ expect(response).to be_success }
      it{ expect(response.content_type).to be_eql 'application/json' }
      it{ expect(response.body).to be_include '"is_correct":false' }

    end

  end

end
