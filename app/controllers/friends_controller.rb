class FriendsController < ApplicationController
  def index
   end

  def list
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        =  Rails.application.secrets.twitter_consumer_key
      config.consumer_secret     =  Rails.application.secrets.twitter_consumer_secret
      config.access_token        = "#{current_user.oauth_token}"
      config.access_token_secret = "#{current_user.oauth_secret}"
    end

    @friends = client.friends.take(30)
  end
end
