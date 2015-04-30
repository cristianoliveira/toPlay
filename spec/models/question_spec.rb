require 'rails_helper'

RSpec.describe Question, :type => :model do
  let(:user){ FactoryGirl.create(:user) }

  describe '#valid?' do
    context 'when description is not present' do
      let(:question){ FactoryGirl.build(:question, description: nil) }

      it { expect(question).not_to be_valid }
      it {
        question.valid?
        expect(question.errors.first).to be_eql [:description, "Pergunta deve ser informada."]
      }
    end
  end

  describe '#liked_by' do
    let(:question){ FactoryGirl.create(:question) }

    context 'when user likes the video' do
      it 'should score +1' do
        expected = question.get_likes.size + 1

        question.liked_by user

        expect(question.get_likes.size).to be_eql expected
      end
    end

    context 'when user likes the video twice' do
      it 'should score not change' do
        expected = question.get_likes.size

        question.liked_by user
        question.liked_by user

        expect(question.get_likes.size).to be_eql expected
      end
    end

    context 'when user likes after dislike' do
      it 'should score not change' do
        expected = question.get_likes.size

        question.liked_by user
        question.disliked_by user

        expect(question.get_likes.size).to be_eql expected
      end
    end

  end

  describe '#disliked_by' do
    let(:question){ FactoryGirl.create(:question) }

    context 'when user dislikes the video' do
      it 'should score +1' do
        expected = question.get_dislikes.size + 1

        question.disliked_by user

        expect(question.get_dislikes.size).to be_eql expected
      end
    end

    context 'when user dislikes the video twice' do
      it 'should score not change' do
        expected = question.get_dislikes.size

        question.disliked_by user
        question.disliked_by user

        expect(question.get_dislikes.size).to be_eql expected
      end
    end

    context 'when user dislikes after like' do
      it 'should score not change' do
        expected = question.get_dislikes.size

        question.disliked_by user
        question.liked_by user

        expect(question.get_dislikes.size).to be_eql expected
      end
    end
  end

  describe '#main?' do
    context 'when question not have parent' do
      let(:question){ FactoryGirl.create(:question) }

      it { expect(question).to be_main }
    end

    context 'when question have parent' do
      let(:main_question){ FactoryGirl.create(:question) }
      let(:question){ FactoryGirl.build(:question) }

      before :each do
        question.parent_id = main_question.id
        question.save
      end

      it { expect(question).not_to be_main }
      it { expect(main_question).to have_answer }
    end
  end

end
