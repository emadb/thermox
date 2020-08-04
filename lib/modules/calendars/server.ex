defmodule Thermox.Calendars.Server do
  use GenServer

  def start_link([id] = args) do
    GenServer.start_link(__MODULE__, args, name: via_tuple(id))
  end

  def init([id]) do
    {:ok, %{room_id: id}}
  end

  defp via_tuple(id) do
    {:via, Registry, {Thermox.Calendars.Registry, id}}
  end
end
