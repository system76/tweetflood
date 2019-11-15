import Config

# Configures the endpoint
config :tweetflood, TweetfloodWeb.Endpoint,
  http: [port: Map.get(System.get_env(), "PORT", 80)],
  url: [host: Map.get(System.get_env(), "HOST", "localhost")],
  live_view: [
    signing_salt:
      Map.get(
        System.get_env(),
        "SIGNING_SALT",
        "aIVGzQU3pTaD5AllSrHa/On5E9bQ6sqd40s/CRWwx7U6EzN8vGQ9gY4cgryulHGU"
      )
  ],
  secret_key_base:
    Map.get(
      System.get_env(),
      "SECRET_KEY_BASE",
      "DeChVr+x8zeL83Bhws3+29VJ3qyAaipMr21b0Wko9YufAoPhOY0q39wQb0IBXdf6"
    )

# Setup Twitter
config :extwitter, :oauth,
  consumer_key: Map.get(System.get_env(), "TWITTER_CONSUMER_KEY"),
  consumer_secret: Map.get(System.get_env(), "TWITTER_CONSUMER_SECRET"),
  access_token: Map.get(System.get_env(), "TWITTER_ACCESS_TOKEN"),
  access_token_secret: Map.get(System.get_env(), "TWITTER_ACCESS_TOKEN_SECRET")

config :extwitter, :stream,
  track: Map.get(System.get_env(), "TWITTER_TRACK_STRING", "#spirited76"),
  user: Map.get(System.get_env(), "TWITTER_USER", "system76")

# Configure your database
config :tweetflood, Tweetflood.Repo,
  username: Map.get(System.get_env(), "DB_USERNAME", "postgres"),
  password: Map.get(System.get_env(), "DB_PASSWORD", "postgres"),
  database: Map.get(System.get_env(), "DB_DATABASE", "tweetflood_prod"),
  hostname: Map.get(System.get_env(), "DB_HOSTNAME", "postgres"),
  pool_size: 15
