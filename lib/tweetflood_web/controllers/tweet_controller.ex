defmodule TweetfloodWeb.TweetController do
  use TweetfloodWeb, :controller

  alias Tweetflood.Tweets

  def index(conn, _params) do
    live_render(conn, TweetfloodWeb.TweetLiveView, session: %{})
  end

  def random(conn, _params) do
    tweet = Tweets.random()

    if not is_nil(tweet) do
      render(conn, TweetfloodWeb.TweetView, "random.html", tweet: tweet)
    else
      send_resp(conn, 404, "Not found")
    end
  end
end
