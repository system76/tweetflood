defmodule TweetfloodWeb.TweetView do
  use TweetfloodWeb, :view

  @doc """
  Finds the latest tweet in a list, and formats the inserted_at date to
  something nice and human readable.
  """
  def latest_tweet_time(tweets) do
    tweets
    |> latest_tweet()
    |> tweet_time()
  end

  @doc """
  Returns the latest tweet from the list.
  """
  def latest_tweet(tweets) do
    tweets
    |> Enum.sort(fn x, y ->
      case DateTime.compare(x.inserted_at, y.inserted_at) do
        :lt -> true
        _ -> false
      end
    end)
    |> Enum.at(0)
  end

  @doc """
  Gives a somewhat human readable time of the tweet.
  """
  def tweet_time(nil), do: "the heat death of the universe"

  def tweet_time(tweet) do
    tweet_date =
      tweet.inserted_at
      |> NaiveDateTime.to_date()
      |> Date.to_string()

    tweet_time =
      tweet.inserted_at
      |> NaiveDateTime.to_time()
      |> Time.to_string()

    "#{tweet_date} at #{tweet_time}"
  end
end
