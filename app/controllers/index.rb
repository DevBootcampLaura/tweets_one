get '/' do

end

get '/:username' do

  # @user = TwitterUser.find_by_username(params[:username])
  # if @user.tweets.empty?
  #   @user.tweets << TwitterUser.fetch_tweets!(@user.username)
  # end
  # @tweets = @user.tweets.limit(10)


  @user = TwitterUser.find_by_username(params[:username])
  if @user.tweets_stale?
    @user.tweets << TwitterUser.fetch_tweets!(@user.username)
  end
  @tweets = @user.tweets.limit(10)

  erb :tweets

end
