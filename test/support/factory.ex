defmodule Tweetflood.Factory do
  @moduledoc """
  This module uses `ExMachina` to create database backed data for testing.
  """

  use ExMachina.Ecto, repo: Tweetflood.Repo

  alias Tweetflood.Schemas

  def tweet_factory do
    %Schemas.Tweet{
      id: sequence(:id, &"#{&1}"),
      text: "Test tweet",
      user_id: sequence(:user_id, &"#{&1}"),
      user_avatar: sequence(:user_avatar, &"#{&1}"),
      user_name: sequence(:user_name, &"#{&1}"),
      user_tag: sequence(:user_tag, &"#{&1}")
    }
  end
end
