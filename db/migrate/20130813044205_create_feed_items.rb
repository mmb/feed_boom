class CreateFeedItems < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.text :title
      t.text :link, null: false
      t.text :author
      t.text :content

      t.references :feed, index: true

      t.timestamps
    end
  end
end
