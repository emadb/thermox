defmodule Thermox.Rooms.Gateway do
  use DynamicSupervisor

  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_link(_) do
    {:ok, _} = DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def start_all_room_monitors do
    Thermox.Rooms.Repo.get_all()
    |> Enum.map(&(&1.id))
    |> Enum.map(&start_room_monitor/1)
  end

  def start_room_monitor(id) do
    case Registry.lookup(Thermox.Rooms.Registry, id) do
      [] ->
        {:ok, _} = DynamicSupervisor.start_child(__MODULE__, {Thermox.Rooms.Server, [id]})
        id

      _ ->
        id
    end
  end
end
