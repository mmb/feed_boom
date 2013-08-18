class FeedsController < ApplicationController

  def show
    @feed = Feed.where(name: params[:feed_name]).first

    unless @feed
      head :not_found and return
    end

    if stale?(@feed)
      respond_to { |format| format.atom }
    end

  end

  def add_item
    feed = Feed.where(name: params[:feed_name]).first_or_create!

    feed.feed_items.create!(title: params[:title], link: params[:link], author: params[:author],
                            content: params[:content])

    head :ok
  end

end
