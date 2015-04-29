require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "GET profile_user" do

    context 'user logged' do
      before :each do
        sign_in
      end

      it "returns http success" do
        get :profile_user
        expect(response).to be_success
      end
    end
  end

  describe "GET uploads" do
    context 'user logged' do
      before :each do
        sign_in
      end
      it "returns http success" do
        get :uploads
        expect(response).to be_success
      end
    end
  end

  describe "GET notifications" do
    context 'user logged' do
      before :each do
        sign_in
      end
      it "returns http success" do
        get :notifications
        expect(response).to be_success
      end
    end
  end

end
