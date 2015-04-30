require 'rails_helper'

describe Video do

  let(:user){ FactoryGirl.create(:user) }

  describe '#create' do
    context 'when try save without title' do
      let(:video) { FactoryGirl.build(:video, title: nil) }

      before { video.valid? }

      it { expect(video).not_to be_valid }
      it { expect(video.errors).not_to be_nil }
      it { expect(video.errors.first).to be_eql [ :title, ":Informe o Título" ] }
    end

    context 'when try save without title' do
      let(:video) { FactoryGirl.build(:video, url: nil) }

      before { video.valid? }

      it { expect(video).not_to be_valid }
      it { expect(video.errors).not_to be_nil }
      it { expect(video.errors.first).to be_eql [ :url, ":Informe a URL do vídeo." ] }
    end

    context 'when try save without title' do
      let(:video) { FactoryGirl.build(:video, topic_id: nil) }

      before { video.valid? }

      it { expect(video).not_to be_valid }
      it { expect(video.errors).not_to be_nil }
      it { expect(video.errors.first).to be_eql [ :topic_id, ":Informe o Tópico para o vídeo." ] }
    end
  end

  describe '#liked_by' do
    let(:video){ FactoryGirl.create(:video) }

    context 'when user likes the video' do
      it 'should score +1' do
        expected = video.get_likes.size + 1

        video.liked_by user

        expect(video.get_likes.size).to be_eql expected
      end
    end

    context 'when user likes the video twice' do
      it 'should score not change' do
        expected = video.get_likes.size

        video.liked_by user
        video.liked_by user

        expect(video.get_likes.size).to be_eql expected
      end
    end

    context 'when user likes after dislike' do
      it 'should score not change' do
        expected = video.get_likes.size

        video.liked_by user
        video.disliked_by user

        expect(video.get_likes.size).to be_eql expected
      end
    end

  end

  describe '#disliked_by' do
    let(:video){ FactoryGirl.create(:video) }

    context 'when user dislikes the video' do
      it 'should score +1' do
        expected = video.get_dislikes.size + 1

        video.disliked_by user

        expect(video.get_dislikes.size).to be_eql expected
      end
    end

    context 'when user dislikes the video twice' do
      it 'should score not change' do
        expected = video.get_dislikes.size

        video.disliked_by user
        video.disliked_by user

        expect(video.get_dislikes.size).to be_eql expected
      end
    end

    context 'when user dislikes after like' do
      it 'should score not change' do
        expected = video.get_dislikes.size

        video.disliked_by user
        video.liked_by user

        expect(video.get_dislikes.size).to be_eql expected
      end
    end
  end

  describe '#get_vote_score' do
    it 'should return like - dislike' do
      video = FactoryGirl.create(:video)
      10.times do |i|
        video.like_by FactoryGirl.create(:user, email: "#{i}@domail.com")
        video.dislike_by FactoryGirl.create(:user, email: "#{i}@domail.com.br")
      end

      expected = video.get_likes.size - video.get_dislikes.size

      expect(video.get_vote_score).to be_eql expected
    end
  end

end
