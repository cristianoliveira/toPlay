require 'spec_helper'
require 'rails_helper'


describe VideosController do
  render_views

  let(:video) { FactoryGirl.create(:video) }
  let(:topic) { FactoryGirl.create(:topic) }
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    sign_in user
    request.env["HTTP_REFERER"] = courses_path
  end

  describe 'GET #show' do
    context 'user not logged' do
      it 'should be redirected' do
        # given
        sign_out
        video_params = { :id => video.id }

        # when
        get :show, video_params

        # then
        expect(response).to be_redirect
      end
    end

    context 'user logged' do
      it 'should not be redirect' do
        get :show, { :id => video.id }
        expect(response).to be_success
      end
    end

    context 'when request without id' do
      it 'should raise error' do
        expect{ get :show }.to raise_error
      end
    end

    context 'when request video with id' do
      it 'should response successful' do
        get :show, { :id => video.id }
        expect(response).to be_success
      end
    end
  end

  describe 'POST #create' do
    context 'when user not logged' do
      it 'should redirect' do
        sign_out
        params = { :video => { title: 'some',
                          description: 'desc',
                          url: 'http://youtube.com',
                          topic_id: topic.id }}
        post :create, params
        expect(response).to be_redirect
      end
    end

    context 'when request html and not send required title' do
      before(:each) do
        post :create, { :video => {
                        # title: 'some',
                        description: 'desc',
                        url: 'http://youtube.com',
                        topic_id: topic.id
                        }
                      }
      end

      it 'should return flash error' do
        expect(flash[:message]).not_to be_nil
      end

      it 'should return message with error' do
        expected = FactoryGirl.build(:video, title: nil)
        expected.valid?

        expect(flash[:message]).to eq expected.errors.full_messages
      end
    end

    context 'when request json and not send url' do
      before :each do
        post :create, { :video => {
                        title: 'some',
                        description: 'desc',
                        # url: 'http://youtube.com',
                        topic_id: topic.id
                      }, format: :json }
      end

      it{ expect(response.status).to be 422 }

      it 'should return json with errors' do
        expected = FactoryGirl.build(:video, url: nil)
        expected.valid?

        expect(response.body).to eq expected.errors.full_messages.to_json
      end

    end

  end

  describe 'GET #upvote' do
    context 'when user not logged' do
      before do
        sign_out
      end

      it 'should redirect user' do
        get :upvote, id: video.id
        expect(response).to be_redirect
      end

      it 'should not change the video score' do
        expected_vote_score = video.get_vote_score
        get :upvote, id: video.id

        expect(video.get_vote_score).to be expected_vote_score
      end
    end

    context 'when user upvote' do
      it 'should score +1' do
        # given
        video = FactoryGirl.create(:video)
        video_params = { id: video.id }
        expected = video.get_likes.size + 1

        # when
        get :upvote, video_params

        # then
        expect(video.get_likes.size).to be expected
      end
    end

    context 'when user upvote twice' do
      it 'should scores +1 and after remove the upvote' do
        expected_score = video.get_vote_score

        get :upvote, id: video.id
        get :upvote, id: video.id

        expect(video.get_vote_score).to be expected_score
      end
    end

    context 'when user downvote after upvote' do
      it 'should scores +1' do
        expected_score = video.get_likes.size + 1

        get :downvote, id: video.id
        get :upvote, id: video.id

        expect(video.get_likes.size).to be expected_score
      end

      it 'should remove downvote' do
        expected_score = video.get_dislikes.size

        get :downvote, id: video.id
        get :upvote, id: video.id

        expect(video.get_dislikes.size).to be expected_score
      end

      it 'should score 0 points for owner' do
        #given
        owner = FactoryGirl.create(:user)
        video = FactoryGirl.create(:video, user: owner)
        video_params = { id: video.id }
        expected = owner.points

        # when
        get :downvote, video_params
        get :upvote, video_params

        # then
        expect(owner.points).to be_eql expected
      end
    end
  end

  describe 'GET #downvote' do
    context 'when user not logged' do
      before do
        sign_out
      end

      it 'should redirect user' do
        get :downvote, id: video.id
        expect(response).to be_redirect
      end

      it 'should not change the video score' do
        expected_vote_score = video.get_vote_score
        get :downvote, id: video.id

        expect(video.get_vote_score).to be expected_vote_score
      end
    end

    context 'when user downvote' do
      it 'should score +1' do
        # given
        expected_score = video.get_dislikes.size + 1

        # when
        get :downvote, id: video.id

        # then
        expect(video.get_dislikes.size).to be expected_score
      end

      it 'should score -5 points for owner' do
        #given
        owner = FactoryGirl.create(:user)
        video = FactoryGirl.create(:video, user: owner)
        video_params = { id: video.id }
        expected = owner.points - 5

        # when
        get :downvote, video_params

        # then
        expect(owner.points).to be expected
      end

    end

    context 'when user downvote twice' do

      it 'should scores +1 and after remove the upvote' do
        expected_score = video.get_vote_score
        get :downvote, id: video.id
        get :downvote, id: video.id
        expect(video.get_vote_score).to be expected_score
      end

      it 'should score -5 points for owner' do
        #given
        owner = FactoryGirl.create(:user)
        video = FactoryGirl.create(:video, user: owner)
        video_params = { id: video.id }
        expected = owner.points - 5

        # when
        get :downvote, video_params
        get :downvote, video_params

        # then
        expect(owner.points).to be_eql expected
      end

    end

    context 'when user upvote after downvote' do
      it 'should scores +1' do
        expected_score = video.get_dislikes.size + 1

        get :upvote, id: video.id
        get :downvote, id: video.id

        expect(video.get_dislikes.size).to be expected_score
      end

      it 'should count only upvote' do
        # given
        expected_score = video.get_likes.size
        video_param = {id: video.id}

        # when
        get :upvote, video_param
        get :downvote, video_param

        # then
        expect(video.get_likes.size).to be expected_score
      end

      it 'should score 0 points for owner' do
        #given
        owner = FactoryGirl.create(:user)
        video = FactoryGirl.create(:video, user: owner)
        video_params = { id: video.id }
        expected = owner.points

        # when
        get :upvote, video_params
        get :downvote, video_params

        # then
        expect(owner.points).to be_eql expected
      end
    end
  end

end
