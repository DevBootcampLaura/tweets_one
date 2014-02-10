class TwitterUser < ActiveRecord::Base
  has_many :tweets
  # Remember to create a migration!

  def self.client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        =  ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = ENV['OAUTH_TOKEN']
      config.access_token_secret = ENV['OAUTH_TOKEN_SECRET']
    end
    client
  end

  def self.get_20_tweets(username)
    self.client.user_timeline(username)
  end

  def self.fetch_tweets!(username)
    tweets = []
    self.get_20_tweets(username).each do |tweet|
      tweets << Tweet.create(content: tweet.text)
    end
    tweets
  end

  def tweets_stale?
    (Time.now - self.tweets.first.created_at.to_time)/60 > 30
  end



end



