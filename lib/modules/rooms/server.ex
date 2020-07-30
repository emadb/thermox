defmodule Thermox.Rooms.Server do
  use GenServer

  alias Thermox.Rooms.Repo

  @polling_interval 1000 * 10

  def start_link([id] = args) do
    GenServer.start_link(__MODULE__, args, name: via_tuple(id))
  end

  def init([id]) do
    {:ok, %{room_id: id, current_temp: "NA"}, {:continue, :setup}}
  end

  def current_temp(id) do
    GenServer.call(via_tuple(id), :current_temp)
  end

  def handle_continue(:setup, state) do
    Process.send_after(self(), :read_room_temperature, @polling_interval)
    {:noreply, state}
  end

  def handle_info(:read_room_temperature, state) do
    temp = get_temperature(state.room_id)
    Repo.insert(state.room_id, temp)
    Process.send_after(self(), :read_room_temperature, @polling_interval)
    {:noreply, %{state | current_temp: temp}}
  end

  def handle_call(:current_temp, _from, state) do
    {:reply, {:ok, state.current_temp}, state}
  end

  defp via_tuple(id) do
    {:via, Registry, {Thermox.Rooms.Registry, id}}
  end

  defp get_temperature(_id) do
    Enum.random(0..1000)
  end
end
