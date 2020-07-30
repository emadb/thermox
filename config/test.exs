import Config

config :thermox, Thermox.Repo,
  database: "thermox_test",
  username: "postgres",
  password: "postgres",
  hostname: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, level: :info
