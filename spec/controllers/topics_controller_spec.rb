require 'rails_helper'

describe TopicsController do

  let(:topic) { FactoryGirl.create(:topic) }
  let(:level) { FactoryGirl.create(:level) }

  describe "GET #show" do
    context "user logged in" do
      before :each do
        sign_in
        get 'show', { id: topic.id }
      end

      it { expect(response).to be_success }
      it { expect(response).to render_template('topics/show')}
      # it { expect(response).to respond_with :html }
    end

    context "user not logged" do
      before :each do
        sign_out
        get :show, { id: topic.id }
      end

      it { expect(response).to be_redirect }
    end
  end

  describe "GET #level_topics" do
    context 'requesting json' do
      before :each do
        sign_in
        get :level_topics, { level_id: level.id, :format => :json }
      end

      it { expect(response).to be_success }
      it { expect(response.content_type).to be_eql "application/json"}
    end

    context 'requesting html' do
      before :each do
        sign_in
      end

      it { expect{ get :level_topics, { level_id: level.id, :format => :html } }.to raise_error }
    end
  end

end
