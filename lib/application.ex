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
      {Registry, [keys: :unique, name: Thermox.Calendars.Registry]},
      {Registry, [keys: :unique, name: Thermox.Controllers.Registry]},
      {Registry, [keys: :duplicate, name: Thermox.PubSub.Registry]},
      {Thermox.ProcessManager, []},
      {Thermox.RoomsSupervisor, []}
    ]

    opts = [strategy: :one_for_one, name: Thermox.Supervisor]
    res = Supervisor.start_link(children, opts)

    Thermox.RoomsSupervisor.start_all_room_supervisors()
    res
  end
end
