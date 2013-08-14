require 'spec_helper'

describe FeedsController do

  describe "GET 'show'" do

    context 'when the feed does not exist' do

      it 'creates the feed' do
        expect {
          get :show, feed_name: 'feed1', format: :atom
        }.to change { Feed.count }.by(1)
      end

      it 'assigns the feed' do
        get :show, feed_name: 'feed1', format: :atom
        expect(assigns(:feed)).to eq Feed.last
      end
      it 'renders the feed' do
        get :show, feed_name: 'feed1', format: :atom
        expect(response).to render_template(:show)
      end
    end

    context 'when the feed exists' do
      it 'renders the feed' do
        get :show, feed_name: 'feed1', format: :atom

        expect(response).to render_template(:show)
      end
    end

    context 'conditional get' do
      it 'returns 304' do
        feed = FactoryGirl.create(:feed)

        request.env['HTTP_IF_MODIFIED_SINCE'] = (feed.updated_at + 1).httpdate

        get :show, feed_name: 'feed1', format: :atom

        expect(response.status).to eq 304
        expect(response.body).to be_empty
      end

    end

  end

end
