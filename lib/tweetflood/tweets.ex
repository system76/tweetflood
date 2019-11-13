defmodule Tweetflood.Tweets do
  @moduledoc """
  Access to saved tweets.
  """

  alias Tweetflood.Repo
  alias Tweetflood.Schemas.Tweet

  import Ecto.Query

  @doc """
  Returns the number of tweets we currently have persisted.
  """
  def count(), do: Repo.aggregate(Tweet, :count, :id)

  @doc """
  Returns the latest tweets we have persisted.

  ## Options:

  * `limit`: The amount of tweets we should return.
  """
  def list(limit \\ 20) do
    Tweet
    |> limit(^limit)
    |> order_by(desc: :id)
    |> Repo.all()
  end

  @doc """
  Creates a new database tweet from twitter.
  """
  def create(tweet) do
    tweet
    |> Tweet.changeset_from_tweet()
    |> Repo.insert()
    |> notify()
  end

  defp notify({:ok, tweet}),
    do: TweetfloodWeb.Endpoint.broadcast("tweet", "new", tweet)
  defp notify(res),
    do: res
end
