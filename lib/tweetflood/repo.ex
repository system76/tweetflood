defmodule Tweetflood.Repo do
  use Ecto.Repo,
    otp_app: :tweetflood,
    adapter: Ecto.Adapters.Postgres
end
