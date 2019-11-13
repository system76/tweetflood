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
  Returns the last tweet we have persisted.
  """
  def last() do
    Tweet
    |> order_by(desc: :id)
    |> limit(1)
    |> Repo.one()
  end

  @doc """
  Creates a new database tweet from twitter.
  """
  def create(tweet) do
    tweet
    |> Tweet.changeset_from_tweet()
    |> Repo.insert([on_conflict: :replace_all, conflict_target: :id])
    |> notify()
  end

  @doc false
  defp notify({:ok, tweet}) do
    TweetfloodWeb.Endpoint.broadcast("tweet", "new", tweet)
    {:ok, tweet}
  end

  defp notify(res),
    do: res
end
