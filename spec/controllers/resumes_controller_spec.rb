require 'rails_helper'

RSpec.describe ResumesController, :type => :controller do

  let(:current_user) { FactoryGirl.create(:user) }
  let(:topic) { FactoryGirl.create(:topic) }

  describe 'POST #create' do
    before do
      sign_in current_user
    end

    context 'when doesn`t required params' do
      before :each do
        # given
        user = current_user
        params = { resume: nil , format: :json }

        # when
        post :create, params
      end

      # then
      it { expect(response).not_to be_success }
      it { expect(response.content_type).to include 'application/json' }
      it { expect(response.body).to include 'error' }
    end

    context 'when send right params' do
      before :each do
        # given
        params = FactoryGirl.build(:resume).attributes

        # when
        post :create, { resume: params, format: :json }
      end

      # then
      it { expect(response).to be_success }
      it { expect(response.content_type).to include 'application/json' }
      it { expect(response.body).not_to include 'error' }

    end

    context 'when missing description' do
      it 'should return json with errors' do
        # given
        stub_resume = FactoryGirl.build(:resume, description: nil)
        stub_resume.valid?
        params = stub_resume.attributes

        # when
        post :create, { resume: params, format: :json }

        # then
        expect(response.body).to include stub_resume.errors.to_json
      end

      it 'should not score owner points' do
        # given
        resume = FactoryGirl.build(:resume, user: current_user, description: nil)
        params = stub_resume.attributes
        expected = current_user.points

        # when
        post :create, { resume: params, format: :json }

        # then
        expect(current_user.points).to be_eql expected
      end
    end

    context 'when current user create resume' do
      it 'should score +250 point for current user' do
        # given
        resume = FactoryGirl.build(:resume, user: current_user)
        params = resume.attributes
        expected = current_user.points + 250

        # when
        post :create, { resume: params, format: :json }

        # then
        expect(current_user.points).to be_eql expected
      end
    end
  end
end
