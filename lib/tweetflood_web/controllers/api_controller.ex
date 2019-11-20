defmodule TweetfloodWeb.ApiController do
  use TweetfloodWeb, :controller

  alias Tweetflood.Tweets

  def index(conn, _params) do
    count = Tweets.count()
    tweets = Tweets.list()

    render(conn, "index.json", %{count: count, tweets: tweets})
  end
end
