require 'rails_helper'

RSpec.describe UserExerciseAnswersHelper, :type => :helper do

  let(:exercise) { FactoryGirl.create :exercise }
  let(:user) { FactoryGirl.create :user }

  describe "#get_answer" do
    it{ expect(get_answer(user, exercise)).to be_instance_of UserExerciseAnswer }
  end

end
