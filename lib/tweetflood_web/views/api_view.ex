defmodule TweetfloodWeb.ApiView do
  use TweetfloodWeb, :view

  def render("index.json", %{count: count, tweets: tweets}) do
    %{
      "count" => count,
      "tweets" =>
        Enum.map(
          tweets,
          &%{
            "text" => &1.text,
            "user_id" => &1.user_id,
            "user_avatar" => &1.user_avatar,
            "user_name" => &1.user_name,
            "user_tag" => &1.user_tag
          }
        )
    }
  end
end
