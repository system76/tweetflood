import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tweetflood, TweetfloodWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :tweetflood, Tweetflood.Repo,
  username: "postgres",
  password: "postgres",
  database: "tweetflood_test",
  hostname: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox
