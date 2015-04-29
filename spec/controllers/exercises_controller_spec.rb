require 'rails_helper'

RSpec.describe ExercisesController, :type => :controller do

  let(:exercise){ FactoryGirl.create(:exercise) }

  describe 'GET #show' do
    context 'user not logged' do
      it 'redirect to sign_in' do
        sign_out
        get :show, id: exercise.id

        expect(response).to be_redirect
      end
    end


    context 'user logged' do
      before :each do
        sign_in
        get :show, id: exercise.id
      end

      it{ expect(response).to be_success }
    end
  end

end
