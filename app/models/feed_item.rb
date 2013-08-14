class FeedItem < ActiveRecord::Base
  belongs_to :feed, touch: true

  validates :link, presence: true
end
