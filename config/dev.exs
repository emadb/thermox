import Config

config :thermox, Thermox.Repo,
  database: "thermox_dev",
  username: "postgres",
  password: "postgres",
  hostname: "postgres"

config :logger, level: :debug
