class UsersController < ApplicationController

  def tweets
    client = Twitter::REST::Client.new do |config|
      config.consumer_key         = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret      = Rails.application.secrets.twitter_consumer_secret
      config.access_token         = "#{current_user.oauth_token}"
      config.access_token_secret  = "#{current_user.oauth_secret}"
    end

    @tweets = client.user_timeline
  end

  def new_tweet
  end

  def post_tweet
    client = Twitter::REST::Client.new do |config|
      config.consumer_key         = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret      = Rails.application.secrets.twitter_consumer_secret
      config.access_token         = "#{current_user.oauth_token}"
      config.access_token_secret  = "#{current_user.oauth_secret}"
    end

    if client.update(params['message'])
      flash[:message] = 'Your message has been posted'
      redirect_to users_tweets_path
    else
      flash[:error] = 'There was a problem with your message'
    end
  end

end
