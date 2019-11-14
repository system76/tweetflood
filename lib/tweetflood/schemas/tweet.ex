defmodule Tweetflood.Schemas.Tweet do
  @moduledoc """
  Database interface for saved Twitter Tweets.
  """

  use Ecto.Schema

  import Ecto.Changeset

  schema "tweets" do
    field :text, :string
    field :user_id, :integer

    timestamps()
  end

  @doc """
  Creates a new `Tweetflood.Schemas.Tweet` changeset.
  """
  def changeset(tweet, params) do
    tweet
    |> cast(params, [:id, :text, :user_id])
    |> validate_required([:id, :text, :user_id])
  end

  @doc """
  Creates a new `Tweetflood.Schemas.Tweet` changeset from a Twitter API tweet
  object.
  """
  def changeset_from_tweet(params) do
    changeset(%__MODULE__{}, %{
      id: Map.get(params, :id),
      text: Map.get(params, :text),
      user_id: params |> Map.get(:user) |> Map.get(:id)
    })
  end
end
