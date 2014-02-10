get '/' do

end

get '/stale' do
  @user = TwitterUser.find_by_username(params[:username])
  @user.tweets << TwitterUser.fetch_tweets!(@user.username)
  @tweets = @user.tweets.limit(10)
  erb :_view_tweets

end

get '/:username' do

  @user = TwitterUser.find_by_username(params[:username])
  if @user.tweets_stale?
    @user.tweets << TwitterUser.fetch_tweets!(@user.username)

    erb :stale
  else
    @tweets = @user.tweets.limit(10)
    erb :tweets
  end

end

get '/followers/:username' do

  twitter_id = TwitterUser.twitter_id(params[:username])
  @followers = TwitterUser.followers(params[:username])
  erb :followers
end

