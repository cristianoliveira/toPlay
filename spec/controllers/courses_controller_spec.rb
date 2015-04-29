require 'rails_helper'

describe CoursesController do

  let(:course){ FactoryGirl.create(:course) }

  describe 'GET #show' do

    it "expect an course id" do
      sign_in
      expect{get :show}.to raise_error ActiveRecord::RecordNotFound
    end

    context 'when user not logged' do
      before :each do
        sign_out
        get :show, { course_id:  course.id }
      end

      it { expect(response).not_to be_redirect }

    end

    context 'when user logged' do
      before :each do
        sign_in
        get :show, { course_id:  course.id }
      end

      it { expect(response).to be_success }
      it { expect(response).not_to be_redirect }

    end
  end

end
