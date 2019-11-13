defmodule TweetfloodWeb.TweetLiveView do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(TweetfloodWeb.TweetView, "index.html", assigns)
  end

  def mount(_session, socket) do
    TweetfloodWeb.Endpoint.subscribe("tweet")

    socket =
      assign(socket,
        count: Tweetflood.Tweets.count(),
        tweets: Tweetflood.Tweets.list()
      )

    {:ok, socket}
  end

  def handle_info(%{event: "new", payload: tweet}, socket) do
    socket =
      assign(socket, %{
        count: socket.assigns.count + 1,
        tweets: Enum.take([tweet | socket.assigns.tweets], 20)
      })

    {:noreply, socket}
  end
end
