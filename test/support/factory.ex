defmodule Tweetflood.Factory do
  use ExMachina.Ecto, repo: Tweetflood.Repo

  alias Tweetflood.Schemas

  def tweet_factory do
    %Schemas.Tweet{
      id: sequence(:id, &"#{&1}"),
      text: "Test tweet",
      user_id: sequence(:user_id, &"#{&1}")
    }
  end
end
