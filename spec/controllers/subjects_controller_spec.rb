require 'rails_helper'

RSpec.describe SubjectsController, :type => :controller do
  render_views

  let(:subject){ FactoryGirl.create(:subject) }

  describe 'GET #level'do
    context 'user not logged' do
      before :each do
        get :levels, {subject_id: subject.id, format: :json }
      end

      it{ expect(response.status).to eq 401 }
      it{ expect(response.content_type).to be_include 'application/json' }
      it{ expect(response.body).to be_include 'error' }

    end

    context 'request json' do
      before :each do
        sign_in
        get :levels, {subject_id: subject.id, format: :json }
      end

      it{ expect(response.content_type).to be_include 'application/json' }

    end


  end

end
