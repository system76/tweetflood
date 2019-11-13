defmodule Tweetflood.TwitterStream do
  @moduledoc """
  GenServer for listening to incoming twitter streams.
  """

  use GenServer

  import Logger

  alias Tweetflood.Tweets

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts)
  end

  @impl true
  def init(_) do
    {:ok, start_stream()}
  end

  defp start_stream() do
    spawn_link(fn ->
      stream = ExTwitter.stream_filter(filter_opts(), :infinity)

      for tweet <- stream do
        handle_tweet(tweet)
      end
    end)
  end

  defp filter_opts() do
    :extwitter
    |> Application.get_env(:stream)
    |> Keyword.take([:track])
  end

  def handle_tweet(tweet) do
    Tweets.create(tweet)
  end
end
