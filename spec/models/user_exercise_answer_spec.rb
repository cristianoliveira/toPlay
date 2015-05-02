require 'rails_helper'

RSpec.describe UserExerciseAnswer, :type => :model do

  describe '#correct?' do
    context 'when answer is correct' do
      it 'should return true' do
        # given
        alternative = FactoryGirl.create(:alternative, correct: true)
        answer = FactoryGirl.create(:user_exercise_answer, alternative: alternative)

        # when
        result = answer.correct?

        # then
        expect(result).to be_eql true
      end
    end

    context 'when answer is incorrect' do
      it 'should return false' do
        # given
        alternative = FactoryGirl.create(:alternative, correct: false)
        answer = FactoryGirl.create(:user_exercise_answer, alternative: alternative)

        # when
        result = answer.correct?

        # then
        expect(result).to be_eql false
      end
    end

  end
end
