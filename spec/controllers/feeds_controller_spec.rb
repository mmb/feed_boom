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

  describe "POST 'add_item'" do

    context 'when the feed does not exist' do

      before(:each) do
        post :add_item, feed_name: 'feed1', title: 'test', link: 'http://test.com/', author: 'a', content: 'c'
      end

      it 'creates the feed' do
        expect(Feed.last.name).to eq 'feed1'
      end

      it 'adds an item to the feed' do
        feed_item = Feed.last.feed_items.first

        expect(feed_item.title).to eq 'test'
        expect(feed_item.link).to eq 'http://test.com/'
        expect(feed_item.author).to eq 'a'
        expect(feed_item.content).to eq 'c'
      end

    end

    context 'when the feed exists' do
      let(:feed) { FactoryGirl.create(:feed) }

      it 'adds an item to the feed' do
        post :add_item, feed_name: feed.name, title: 'test', link: 'http://test.com/', author: 'a', content: 'c'

        last = feed.feed_items.last

        expect(last.title).to eq 'test'
        expect(last.link).to eq 'http://test.com/'
        expect(last.author).to eq 'a'
        expect(last.content).to eq 'c'
      end

    end

  end

end
