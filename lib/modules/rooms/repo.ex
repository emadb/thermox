defmodule Thermox.Rooms.Repo do
  alias Thermox.Rooms.Schemas.Temperature

  def get_all() do
    Thermox.Rooms.Schemas.Room
    |> Thermox.Repo.all()
  end

  def insert(room_id, temp) do
    t = %Temperature{
      room_id: room_id,
      date: DateTime.utc_now(),
      value: temp / 10
    }

    {:ok, _} = Thermox.Repo.insert(t)
  end
end
