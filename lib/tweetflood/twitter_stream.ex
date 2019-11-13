defmodule Tweetflood.TwitterStream do
  @moduledoc """
  GenServer for listening to incoming twitter streams.
  """

  use GenServer

  import Logger

  alias Tweetflood.Tweets

  # Refresh every minute
  @refresh_time_in_milliseconds 1 * 60 * 1_000

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts)
  end

  @impl true
  def init(state) do
    last_tweet = Tweetflood.Tweets.last()
    state = update_state_last_tweet_id(state, last_tweet)

    send(self(), :tick)

    {:ok, state}
  end


  def handle_info(:tick, state) do
    Process.send_after(self(), :tick, @refresh_time_in_milliseconds)

    send(self(), :fetch)

    {:noreply, state}
  end

  @doc """
  Fetches all the new likes from the configured user.
  """
  @impl true
  def handle_info(:fetch, state) do
    Logger.debug(fn -> "Fetching new tweets" end)

    tweets =
      []
      |> Keyword.put(:count, 200)
      |> Keyword.put(:screen_name, configuration()[:user])
      |> Keyword.put(:since_id, state[:last_tweet_id])
      |> ExTwitter.API.Favorites.favorites()
      |> Enum.filter(&part_of_campaign?/1)

    send(self(), {:new, tweets})

    {:noreply, state}
  end

  @doc """
  Handles persisting new tweets to the database
  """
  @impl true
  def handle_info({:new, tweets}, state) when is_list(tweets) do
    Logger.debug(fn -> "Adding #{length(tweets)} tweets" end)

    Enum.each(tweets, &send(self(), {:new, &1}))
    {:noreply, state}
  end

  @impl true
  def handle_info({:new, tweet}, state) do
    Logger.debug(fn -> "Adding new tweet #{tweet.id}" end)

    tweet = Tweets.create(tweet)
    state = update_state_last_tweet_id(state, tweet)

    {:noreply, state}
  end

  @doc false
  defp update_state_last_tweet_id(state, nil), do: state

  defp update_state_last_tweet_id([last_tweet_id: nil] = state, %{id: id}),
    do: Keyword.put(state, :last_tweet_id, id)

  defp update_state_last_tweet_id(state, tweet) do
    if state[:last_tweet_id] < tweet.id do
      Keyword.put(state, :last_tweet_id, tweet.id)
    else
      state
    end
  end

  @doc false
  defp part_of_campaign?(tweet) do
    Enum.all?(filter_words(), &String.contains?(&1, tweet.text))
  end

  @doc false
  defp configuration() do
    Application.get_env(:extwitter, :stream)
  end

  @doc false
  defp filter_words() do
    configuration()
    |> Keyword.get(:track)
    |> String.split(" ")
  end
end
