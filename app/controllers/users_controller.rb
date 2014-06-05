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

  def edit_profile
    client = Twitter::REST::Client.new do |config|
      config.consumer_key         = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret      = Rails.application.secrets.twitter_consumer_secret
      config.access_token         = "#{current_user.oauth_token}"
      config.access_token_secret  = "#{current_user.oauth_secret}"
    end

    @user = client.user
  end

  def update_profile
    client = Twitter::REST::Client.new do |config|
      config.consumer_key         = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret      = Rails.application.secrets.twitter_consumer_secret
      config.access_token         = "#{current_user.oauth_token}"
      config.access_token_secret  = "#{current_user.oauth_secret}"
    end

    if client.update_profile(params)
      flash[:message] = 'Profile updated successfully'
      redirect_to root_path
    else
      flash[:error] = 'Profile not updated'
      render edit_profile
    end
  end

  def suggestions
    client = Twitter::REST::Client.new do |config|
      config.consumer_key         = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret      = Rails.application.secrets.twitter_consumer_secret
      config.access_token         = "#{current_user.oauth_token}"
      config.access_token_secret  = "#{current_user.oauth_secret}"
    end

   #@suggestions = []
    #slugs = client.suggestions
    #slugs.each do |sl|
    #  @suggestions << client.suggest_users(sl.slug)
    #end
    #return @suggestions
    #@suggestions = client.suggestions
    # TODO: Problem when getting the list of slugs from above
    @suggestions = client.suggest_users('Sport')
  end

  def add_friend
    client = Twitter::REST::Client.new do |config|
      config.consumer_key         = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret      = Rails.application.secrets.twitter_consumer_secret
      config.access_token         = "#{current_user.oauth_token}"
      config.access_token_secret  = "#{current_user.oauth_secret}"
    end

    if client.follow(params)
      flash[:message] = 'Friend has been created'
      redirect_to friends_list_path
    else
      flash[:error] = 'Friend cannot be added'
      render suggestions
    end
  end

  def search
  end

  def search_results
    client = Twitter::REST::Client.new do |config|
      config.consumer_key         = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret      = Rails.application.secrets.twitter_consumer_secret
      config.access_token         = "#{current_user.oauth_token}"
      config.access_token_secret  = "#{current_user.oauth_secret}"
    end

    @users = client.users(params[:name])

    unless @users.nil?
      flash[:message] = 'The following users have been found'
    else
      flash[:error] = 'Sorry no users match your search criteria'
    end
  end

  def show_found_user_tweets
    client = Twitter::REST::Client.new do |config|
      config.consumer_key         = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret      = Rails.application.secrets.twitter_consumer_secret
      config.access_token         = "#{current_user.oauth_token}"
      config.access_token_secret  = "#{current_user.oauth_secret}"
    end

    @user_tweets = client.user_timeline(user_id: params[:user_id])
  end
end
