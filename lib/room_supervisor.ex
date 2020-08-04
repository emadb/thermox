defmodule Thermox.RoomsSupervisor do
  use DynamicSupervisor

  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_link(_) do
    {:ok, _} = DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def start_all_room_supervisors do
    Thermox.Rooms.Repo.get_all()
    |> Enum.map(&(&1.id))
    |> Enum.map(&start_room/1)
  end

  def start_room(room_id) do
    opts = [strategy: :one_for_all, name: Thermox.SingleRoomSupervisor]
    children = [
      {Thermox.Rooms.Server, [room_id]},
      {Thermox.Calendars.Server, [room_id]},
      {Thermox.Controllers.Server, [room_id]},
    ]
    Supervisor.start_link(children, opts)
  end
end
