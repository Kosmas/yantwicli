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

    @friends = client.friends.take(10)
  end

  def remove_friend
    client = Twitter::REST::Client.new do |config|
      config.consumer_key         = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret      = Rails.application.secrets.twitter_consumer_secret
      config.access_token         = "#{current_user.oauth_token}"
      config.access_token_secret  = "#{current_user.oauth_secret}"
    end

    # TODO: Does it work? Need to investigate
    # no error produced but user not removed
    if client.unfollow(params)
      flash[:message] = 'User has been removed'
      redirect_to root_path
    else
      flash[:error] = 'User cannot be removed'
      render 'list'
    end
  end

  def messages
    client = Twitter::REST::Client.new do |config|
      config.consumer_key         = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret      = Rails.application.secrets.twitter_consumer_secret
      config.access_token         = "#{current_user.oauth_token}"
      config.access_token_secret  = "#{current_user.oauth_secret}"
    end

    @messages = client.home_timeline
  end

  def reply_tweet
    @screen_name = '@' + params[:screen_name]
  end

  def post_reply_tweet
    client = Twitter::REST::Client.new do |config|
      config.consumer_key         = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret      = Rails.application.secrets.twitter_consumer_secret
      config.access_token         = "#{current_user.oauth_token}"
      config.access_token_secret  = "#{current_user.oauth_secret}"
    end

    if client.update(params['message'])
      flash[:message] = 'Your reply has been posted'
      redirect_to friends_messages_path
    else
      flash[:error] = 'There was a problem with your message'
      render reply_tweet
    end
  end
end
