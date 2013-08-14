class Feed < ActiveRecord::Base
  has_many :feed_items, -> { order(:updated_at).reverse_order }

  validates :name, presence: true, uniqueness: true
end
