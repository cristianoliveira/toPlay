require 'rails_helper'

describe MainController do

  describe "GET #about" do
    before :each do
      get :about
    end

    it { expect(response).to be_success }

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
