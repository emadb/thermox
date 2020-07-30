import Config

config :thermox,
  ecto_repos: [Thermox.Repo]

config :thermox,
       Thermox.Repo,
       migration_timestamps: [type: :utc_datetime]

import_config "#{Mix.env()}.exs"
