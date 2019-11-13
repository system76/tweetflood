# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tweetflood,
  ecto_repos: [Tweetflood.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :tweetflood, TweetfloodWeb.Endpoint,
  http: [port: System.get_env("PORT") || 4000],
  url: [host: "localhost"],
  live_view: [signing_salt: "aIVGzQU3pTaD5AllSrHa/On5E9bQ6sqd40s/CRWwx7U6EzN8vGQ9gY4cgryulHGU"],
  secret_key_base: "glSJSj5fgUUIjDPdFSdZvODD+rjy6zM1TrmsIfjN7nFKoxojuKrKPiLS5ichWunh",
  render_errors: [view: TweetfloodWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tweetflood.PubSub, adapter: Phoenix.PubSub.PG2]

# Setup Twitter
config :extwitter, :oauth,
  consumer_key: "aaaaaaaaaaaaaaaaaaaaaaaaa",
  consumer_secret: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
  access_token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
  access_token_secret: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

config :extwitter, :stream, track: "trump"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Setup Phoenix live view template compiling
config :phoenix,
  template_engines: [leex: Phoenix.LiveView.Engine]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

try do
  import_config "#{Mix.env()}.secret.exs"
rescue
  Code.LoadError -> :no_op
end
