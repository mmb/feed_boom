class AddWriteAuthToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :write_auth, :string
  end
end
