defmodule Tweetflood.Schemas.Tweet do
  @moduledoc """
  Database interface for saved Twitter Tweets.
  """

  use Ecto.Schema

  import Ecto.Changeset

  schema "tweets" do
    field :text, :string

    field :user_id, :integer
    field :user_avatar, :string
    field :user_name, :string
    field :user_tag, :string

    timestamps()
  end

  @fields ~w(
    id
    text
    user_id
    user_avatar
    user_name
    user_tag
  )a

  @doc """
  Creates a new `Tweetflood.Schemas.Tweet` changeset.
  """
  def changeset(tweet, params) do
    tweet
    |> cast(params, @fields)
    |> validate_required(@fields)
  end

  @doc """
  Creates a new `Tweetflood.Schemas.Tweet` changeset from a Twitter API tweet
  object.
  """
  def changeset_from_tweet(params) do
    changeset(%__MODULE__{}, %{
      id: Map.get(params, :id),
      text: Map.get(params, :full_text),
      user_id: params |> Map.get(:user) |> Map.get(:id),
      user_avatar: params |> Map.get(:user) |> Map.get(:profile_image_url_https),
      user_name: params |> Map.get(:user) |> Map.get(:name),
      user_tag: params |> Map.get(:user) |> Map.get(:screen_name)
    })
  end
end
