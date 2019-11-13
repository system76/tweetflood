defmodule TweetfloodWeb.TweetController do
  use TweetfloodWeb, :controller

  def index(conn, _params) do
    live_render(conn, TweetfloodWeb.TweetLiveView, session: %{})
  end
end
