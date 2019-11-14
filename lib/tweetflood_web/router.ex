defmodule TweetfloodWeb.Router do
  use TweetfloodWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", TweetfloodWeb do
    pipe_through :browser

    get "/", TweetController, :index
    get "/random", TweetController, :random
  end
end
