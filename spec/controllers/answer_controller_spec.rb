require 'spec_helper'
require 'rails_helper'

RSpec.describe AnswerController, :type => :controller do

  def valid_params
     {
     	:answer_id   => 1
     }
  end

  describe "GET get_correct_answer" do
    it "returns http success" do
      get :get_answer, valid_params
      expect(response).to be_success
    end
  end

end
