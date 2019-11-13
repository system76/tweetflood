defmodule TweetfloodWeb.LayoutView do
  use TweetfloodWeb, :view

  def has_alert?(conn) do
    [:info, :error]
    |> Enum.map(fn level -> get_flash(conn, level) end)
    |> Enum.any?(fn message -> not is_nil(message) end)
  end
end
