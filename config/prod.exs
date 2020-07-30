import Config

config :thermox,
  port: 80

config :thermox, Thermox.Repo,
  ssl: true,
  url: System.get_env("DATABASE_URL")

config :logger, level: :info
