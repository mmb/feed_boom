require 'spec_helper'

describe Feed do

  it { should have_many :feed_items }

  it { should validate_presence_of(:name) }

  it { should validate_uniqueness_of(:name) }

  describe '#write_auth=' do

    it 'encrypts the write_auth with bcrypt' do
      BCrypt::Password.stub(create: 'encrypted')

      feed = Feed.new
      feed.write_auth = 'foo'
      expect(feed.write_auth).to eq 'encrypted'
    end

    it 'does not encrypt write_auth if it is nil' do
      feed = Feed.new
      feed.write_auth = nil
      expect(feed.write_auth).to be_nil
    end

    it 'does not encrypt write_auth if it is empty' do
      feed = Feed.new
      feed.write_auth = ''
      expect(feed.write_auth).to be_nil
    end

  end

  describe '#auth' do

    context 'when write_auth is nil' do
      it 'authenticates' do
        feed = Feed.new
        expect(feed.auth('secret')).to be_true
      end
    end

    context 'when write_auth is set' do

      it 'authenticates with the right password' do
        feed = Feed.new(write_auth: 'secret')
        expect(feed.auth('secret')).to be_true
      end

      it 'does not authenticate with the wrong password' do
        feed = Feed.new(write_auth: 'secret')
        expect(feed.auth('wrong')).to be_false
      end

    end

  end
end
