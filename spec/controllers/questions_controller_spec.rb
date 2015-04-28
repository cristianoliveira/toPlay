require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do

  let(:question) { FactoryGirl.create(:question) }
  let(:topic) { FactoryGirl.create(:topic) }
  let(:params) { { :question => { :description => "some", :topic_id => topic.id } } }
  let(:invalid_params) { { :description => nil } }

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
        post :create, params
      end

      it{ expect(response).to be_success }
      it{ expect(flash[:message]).to be_nil }
    end

    context 'when request response json' do
      before :each do
        sign_in
        request.headers["accept"] = 'application/json'
        post :create, params
      end

      it{ expect(response).to be_success }
      it{ expect(flash[:message]).to be_nil }
      it{ expect(response.content_type).to be_eql "application/json" }
    end

    context 'when request invalid' do
      before :each do
        sign_in
        post :create, invalid_params
      end

      it{ expect(response).to be_success }
      it{ expect(flash[:message]).not_to be_empty }
    end

    context 'when request invalid response json' do
      before :each do
        sign_in
        request.headers["accept"] = 'application/json'
        post :create, invalid_params
      end

      it{ expect(response).not_to be_success }
      it{ expect(response.status).to be 422 }
      it{ expect(flash[:message]).to be_nil }
      it{ expect(response.content_type).to be_eql "application/json" }
    end

    context 'when user not logged' do
      before :each do
        sign_out
        post :create, params
      end

      it { expect(response).to be_redirect }
    end
  end
end
