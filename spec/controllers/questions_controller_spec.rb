require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do

  let(:current_user) { FactoryGirl.create(:user) }
  let(:question) { FactoryGirl.create(:question) }
  let(:topic) { FactoryGirl.create(:topic) }

  before do
    sign_in current_user
    request.env["HTTP_REFERER"] = courses_path # set current url for each action
  end

  describe 'GET #show' do
    context 'when user logged' do
      before :each do
        sign_in
        get :show, id: question.id
      end

      it{ expect(response).to be_success }
      it{ expect(response).not_to render_template :application }
      it{ expect(response).to render_template "questions/show" }
    end

    context 'when user not logged' do
      before :each do
        sign_out
        get :show, id: question.id
      end

      it { expect(response).to be_redirect }
    end
  end

  describe 'GET #create' do
    context 'when user logged create' do
      before :each do
        sign_in
        post :create, { :question => { :description => "some", :topic_id => topic.id } }
      end

      it{ expect(response).to be_success }
      it{ expect(flash[:message]).to be_nil }
    end

    context 'when request response json' do
      before :each do
        sign_in
        request.headers["accept"] = 'application/json'
        post :create, { :question => FactoryGirl.build(:question).attributes }
      end

      it{ expect(response).to be_success }
      it{ expect(flash[:message]).to be_nil }
      it{ expect(response.content_type).to be_eql "application/json" }
    end

    context 'when request invalid' do
      before :each do
        sign_in
        post :create, { :question => FactoryGirl.build(:question, description: nil).attributes }
      end

      it{ expect(response).to be_success }
      it{ expect(flash[:message]).not_to be_empty }
    end

    context 'when request invalid response json' do
      before :each do
        sign_in
        request.headers["accept"] = 'application/json'
        post :create, { :description => nil }
      end

      it{ expect(response).not_to be_success }
      it{ expect(response.status).to be 422 }
      it{ expect(flash[:message]).to be_nil }
      it{ expect(response.content_type).to be_eql "application/json" }
    end

    context 'when user not logged' do
      before :each do
        sign_out
        post :create, { :question => FactoryGirl.build(:question).attributes }
      end

      it { expect(response).to be_redirect }
    end
  end

  describe 'GET #upvote' do
    context 'when user not logged' do
      before do
        sign_out
      end

      it 'should redirect user' do
        get :upvote, id: question.id
        expect(response).to be_redirect
      end

      it 'should not change the question score' do
        expected_vote_score = question.get_vote_score
        get :upvote, id: question.id

        expect(question.get_vote_score).to be expected_vote_score
      end
    end

    context 'when user upvote' do
      it 'should score +1' do
        # given
        # question = FactoryGirl.create(:question)
        question_params = { id: question.id }
        expected = question.get_likes.size + 1

        # when
        get :upvote, question_params

        # then
        p response.body
        expect(question.get_likes.size).to be expected
      end

      it 'should score +5 points for owner' do
        # given
        owner = FactoryGirl.create(:user)
        question = FactoryGirl.create(:question, user: owner)
        question_params = { id: question.id }
        expected = owner.points + 5

        # when
        get :upvote, question_params

        # then
        expect(owner.points).to be expected
      end
    end

    context 'when user upvote twice' do
      it 'should scores +1 after remove the upvote' do
        expected_score = question.get_vote_score

        get :upvote, id: question.id
        get :upvote, id: question.id

        expect(question.get_vote_score).to be expected_score
      end

      it 'should score only +5 for owner' do
        # given
        owner = FactoryGirl.create(:user)
        question = FactoryGirl.create(:question, user: owner)
        question_params = { id: question.id }
        expected = owner.points + 5

        # when
        get :upvote, question_params
        get :upvote, question_params

        # then
        expect(owner.points).to be expected
      end
    end

    context 'when user downvote after upvote' do
      it 'should scores +1' do
        expected_score = question.get_likes.size + 1

        get :downvote, id: question.id
        get :upvote, id: question.id

        expect(question.get_likes.size).to be expected_score
      end

      it 'should remove downvote' do
        expected_score = question.get_dislikes.size

        get :downvote, id: question.id
        get :upvote, id: question.id

        expect(question.get_dislikes.size).to be expected_score
      end

      it 'should score only +5 and -5 points for owner' do
        #given
        owner = FactoryGirl.create(:user)
        question = FactoryGirl.create(:question, user: owner)
        question_params = { id: question.id }
        expected = owner.points

        # when
        get :downvote, question_params
        get :upvote, question_params

        # then
        expect(owner.points).to be_eql expected
      end
    end
  end

  describe 'GET #downvote' do
    context 'when user not logged' do
      before do
        sign_out
      end

      it 'should redirect user' do
        get :downvote, id: question.id
        expect(response).to be_redirect
      end

      it 'should not change the question score' do
        expected_vote_score = question.get_vote_score
        get :downvote, id: question.id

        expect(question.get_vote_score).to be expected_vote_score
      end
    end

    context 'when user downvote once' do
      it 'should score +1' do
        # given
        # question = FactoryGirl.create(:question)
        question_params = { id: question.id }
        expected = question.get_dislikes.size + 1

        # when
        get :downvote, question_params

        # then
        expect(question.get_dislikes.size).to be expected
      end

      it 'should score -5 points for owner' do
        # given
        owner = FactoryGirl.create(:user)
        question = FactoryGirl.create(:question, user: owner)
        question_params = { id: question.id }
        expected = owner.points - 5

        # when
        get :downvote, question_params

        # then
        expect(owner.points).to be expected
      end
    end

    context 'when user downvote twice' do
      it 'should scores +1 after remove the upvote' do
        expected_score = question.get_vote_score

        get :upvote, id: question.id
        get :upvote, id: question.id

        expect(question.get_vote_score).to be expected_score
      end

      it 'should score only -5 for owner' do
        # given
        owner = FactoryGirl.create(:user)
        question = FactoryGirl.create(:question, user: owner)
        question_params = { id: question.id }
        expected = owner.points - 5

        # when
        get :downvote, question_params
        get :downvote, question_params

        # then
        expect(owner.points).to be expected
      end
    end

    context 'when user upvote after downvote' do
      it 'should scores +1' do
        expected_score = question.get_dislikes.size + 1

        get :upvote, id: question.id
        get :downvote, id: question.id

        expect(question.get_dislikes.size).to be expected_score
      end

      it 'should remove upvote score' do
        expected_score = question.get_likes.size

        get :upvote, id: question.id
        get :downvote, id: question.id

        expect(question.get_likes.size).to be expected_score
      end

      it 'should score + 5 and -5 points for owner' do
        #given
        owner = FactoryGirl.create(:user)
        question = FactoryGirl.create(:question, user: owner)
        question_params = { id: question.id }
        expected = owner.points

        # when
        get :upvote, question_params
        get :downvote, question_params

        # then
        expect(owner.points).to be expected
      end
    end
  end

end
