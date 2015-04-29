require 'rails_helper'

RSpec.describe SubjectsController, :type => :controller do

  let(:subject){ FactoryGirl.create(:subject) }

  describe 'GET #level'do
    context 'user not logged' do
      it{
        sign_out
        get :levels, {subject_id: subject.id}
        expect(response).to be_redirect '/users/sign_in'
      }
    end

    context 'user not logged' do
      before :each do
        sign_in
        get :levels, {subject_id: subject.id}
      end

      it{ expect(response).not_to be_redirect '/users/sign_in' }
    end

    context 'request json' do
      before :each do
        sign_in
        get :levels, {subject_id: subject.id, format: :json }
      end

      it{ expect(response.content_type).to be_eql? 'application/json' }
      it{ expect(response.body).to be_include '"subject_id":'+subject.id }

    end


  end

end
