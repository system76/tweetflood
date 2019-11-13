defmodule TweetfloodWeb.TweetChannel do
  @moduledoc """
  Socket channel for persisted tweets
  """

  use TweetfloodWeb, :channel
  alias Tweetflood.Presence

  def join("tweet", _params, socket) do
    send(self(), :after_join)
    {:ok, %{}, socket}
  end

  def handle_info(:after_join, socket) do
    {:noreply, socket}
  end

  intercept(["new"])

  def handle_out("new", tweet, socket) do
    push(socket, "new", tweet)
    {:noreply, socket}
  end
end
