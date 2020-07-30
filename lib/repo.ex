defmodule Thermox.Repo do
  use Ecto.Repo,
    otp_app: :thermox,
    adapter: Ecto.Adapters.Postgres
end
