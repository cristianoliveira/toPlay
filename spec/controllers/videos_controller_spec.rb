require 'spec_helper'
require 'rails_helper'


describe VideosController do
    render_views

    let(:user) { FactoryGirl.create(:user) }
    let(:topic) { FactoryGirl.create(:topic, user: user) }
    let(:valid_params) {
      {
        :topic => topic.id,
        :video => {
            :url       => 'http://google.com', 
            :channel   => 'some channel', 
            :title     => 'some title', 
            :description	=>  'some description'
        }
      }
    }

    before do
      sign_in user
    end  

    describe "GET 'new'" do
      describe "expect to be success" do
        it "when receive :topic" do
          get :new, { topic: topic.id }
          expect(response).to be_success
        end

        it "when doesn't receive param" do
          get :new
          expect(response).to be_success
        end
      end
    end
    
    describe "POST 'create'" do
      describe 'when valid expect' do
        it "to create a new video" do
            post :create,  valid_params  
            
            video = topic.videos.first
            
            expect(video).not_to be_nil
            
            expect(video.url).to be     == valid_params[:video][:url]
            expect(video.channel).to be == valid_params[:video][:channel]
            expect(video.title).to be   == valid_params[:video][:title]
            
            expect(response).to be_redirect
        end
	    end

      describe 'when not send any params' do
        it 'raise error' do
           expect{ post :create }.to raise_error
        end
      end
    end
end
