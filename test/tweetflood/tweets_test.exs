defmodule Tweetflood.TweetsTest do
  use Tweetflood.DataCase

  alias Tweetflood.Tweets

  def extweet_fixture(opts \\ []) do
    %ExTwitter.Model.Tweet{
      id: Keyword.get(opts, :id, "123456"),
      text: Keyword.get(opts, :text, "This is a test"),
      user: %ExTwitter.Model.User{
        id: Keyword.get(opts, :user_id, "123456")
      }
    }
  end

  setup do
    TweetfloodWeb.Endpoint.subscribe("tweet")

    on_exit(fn ->
      TweetfloodWeb.Endpoint.unsubscribe("tweet")
    end)

    :ok
  end

  test "count/0 returns an accurate count of records in database" do
    insert(:tweet)

    assert Tweets.count() == 1
  end

  test "list/1 returns a list of the latest tweets" do
    tweets = insert_list(50, :tweet)

    assert Enum.at(Tweets.list(), 0) == Enum.at(tweets, 49)
    assert Enum.at(Tweets.list(), 1) == Enum.at(tweets, 48)
  end

  test "last/0 returns the most recent tweet" do
    tweets = insert_list(2, :tweet)

    assert Tweets.last() == Enum.at(tweets, 1)
  end

  test "create/1 will create a tweet from extwitter" do
    extweet = extweet_fixture()

    {:ok, tweet} = Tweets.create(extweet)

    assert to_string(tweet.id) == extweet.id
    assert tweet.text == extweet.text
    assert to_string(tweet.user_id) == extweet.user.id
  end

  test "create/1 will broadcast when a new tweet is created" do
    extweet = extweet_fixture()

    {:ok, tweet} = Tweets.create(extweet)

    assert_receive %Phoenix.Socket.Broadcast{
      event: "new",
      topic: "tweet",
      payload: tweet
    }
  end
end
