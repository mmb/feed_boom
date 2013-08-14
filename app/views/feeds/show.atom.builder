atom_feed do |feed|
  feed.title(@feed.name)
  feed.updated(@feed.updated_at)

  @feed.feed_items.each do |feed_item|
    feed.entry(feed_item, url: feed_item.link) do |entry|
      entry.title(feed_item.title)
      entry.author do |author|
        author.name(feed_item.author)
      end
      entry.content(feed_item.content)
    end
  end
end
