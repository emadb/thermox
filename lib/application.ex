defmodule Thermox.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    port = String.to_integer(System.get_env("PORT") || "4000")

    children = [
      {Plug.Cowboy, scheme: :http, plug: Thermox.Api.Router, options: [port: port]},
      Thermox.Repo,
      {Registry, [keys: :unique, name: Thermox.Rooms.Registry]},
      {Thermox.Rooms.Gateway, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Thermox.Supervisor]
    res = Supervisor.start_link(children, opts)

    Thermox.Rooms.Gateway.start_all_room_monitors()
    res
  end
end
