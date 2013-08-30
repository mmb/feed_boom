require 'bcrypt'

class Feed < ActiveRecord::Base
  has_many :feed_items, -> { order(:updated_at).reverse_order }

  validates :name, presence: true, uniqueness: true

  def write_auth=(write_auth)
    write_attribute(:write_auth, BCrypt::Password.create(write_auth)) unless write_auth.blank?
  end

  def auth(password)
    write_auth.nil? || BCrypt::Password.new(write_auth) == password
  end

end
