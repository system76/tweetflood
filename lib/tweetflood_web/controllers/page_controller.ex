defmodule TweetfloodWeb.PageController do
  use TweetfloodWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
