require 'rails_helper'

RSpec.describe MainController, :type => :controller do

  describe "GET about" do
    it "returns http success" do
      get :about
      expect(response).to be_success
    end
  end

  describe "GET courses" do
    it "returns http success" do
      get :courses
      expect(response).to be_success
    end
  end

  describe "GET rank" do
    it "returns http success" do
      get :rank
      expect(response).to be_success
    end
  end

  describe "GET contact" do
    it "returns http success" do
      get :contact
      expect(response).to be_success
    end
  end

end
