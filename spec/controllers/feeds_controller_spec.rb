require 'spec_helper'

describe FeedsController do

  describe "GET 'show'" do

    context 'when the feed does not exist' do

      it 'returns not found' do
        get :show, feed_name: 'feed1', format: :atom

        assert_response 404
      end

    end

    context 'when the feed exists' do
      it 'renders the feed' do
        FactoryGirl.create(:feed, name: 'feed1')

        get :show, feed_name: 'feed1', format: :atom

        expect(response).to render_template(:show)
      end
    end

    context 'conditional get' do
      it 'returns 304' do
        feed = FactoryGirl.create(:feed, name: 'feed1')

        request.env['HTTP_IF_MODIFIED_SINCE'] = (feed.updated_at + 1).httpdate

        get :show, feed_name: 'feed1', format: :atom

        expect(response.status).to eq 304
        expect(response.body).to be_empty
      end

    end

  end

  describe "POST 'add_item'" do

    context 'when the feed does not exist' do

      it 'creates the feed' do
        post :add_item, feed_name: 'feed1', title: 'test', link: 'http://test.com/', author: 'a', content: 'c'

        expect(Feed.last.name).to eq 'feed1'
      end

      it 'adds an item to the feed' do
        post :add_item, feed_name: 'feed1', title: 'test', link: 'http://test.com/', author: 'a', content: 'c'

        feed_item = Feed.last.feed_items.first

        expect(feed_item.title).to eq 'test'
        expect(feed_item.link).to eq 'http://test.com/'
        expect(feed_item.author).to eq 'a'
        expect(feed_item.content).to eq 'c'
      end

      it 'sets the write authorization if provided' do
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(
            nil, 'secret')
        post :add_item, feed_name: 'feed1', title: 'test', link: 'http://test.com/', author: 'a', content: 'c'

        expect(Feed.last.write_auth).to_not be_nil
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

      context 'when the feed has a password' do
        let(:feed) { FactoryGirl.create(:feed, write_auth: 'secret') }
        let(:try_password) { 'secret' }

        before do
          request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(
              nil, try_password)
        end

        context 'when the password is correct' do

          it 'adds an item to the feed' do
            expect {
              post :add_item, feed_name: feed.name, link: 'http://test.com/'
            }.to change { Feed.count }.by(1)
          end

        end

        context 'when the password is incorrect' do
          let(:try_password) { 'wrong' }

          it 'returns unauthorized' do
            post :add_item, feed_name: feed.name, link: 'http://test.com/'

            assert_response 401
          end

        end
      end

    end

  end

end
