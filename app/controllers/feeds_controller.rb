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
    feed = Feed.where(name: params[:feed_name]).take

    if feed
      request_http_basic_authentication && return unless feed.auth(basic_auth_password)
    else
      feed = Feed.create(name: params[:feed_name], write_auth: basic_auth_password)
    end

    feed.feed_items.create!(title: params[:title], link: params[:link], author: params[:author],
                            content: params[:content])

    head :ok
  end

  private

  def basic_auth_password
    if request.env['HTTP_AUTHORIZATION']
      _, password = ActionController::HttpAuthentication::Basic::user_name_and_password(request)

      password
    end
  end

end
