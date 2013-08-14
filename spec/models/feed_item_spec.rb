require 'spec_helper'

describe FeedItem do

  it { should belong_to :feed }

  it { should validate_presence_of :link }

  it 'touches the feed when updated' do
    feed = FactoryGirl.create(:feed)

    expect { feed.feed_items.create!(link: 'link'); feed.reload }.to change { feed.updated_at }
  end

end
