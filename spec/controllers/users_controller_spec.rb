require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "GET profile_user" do
    it "returns http success" do
      get :profile_user
      expect(response).to be_success
    end
  end

  describe "GET uploads" do
    it "returns http success" do
      get :uploads
      expect(response).to be_success
    end
  end

  describe "GET notifications" do
    it "returns http success" do
      get :notifications
      expect(response).to be_success
    end
  end

end
