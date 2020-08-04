defmodule Thermox.Calendars.Server do
  use GenServer

  def start_link([id] = args) do
    GenServer.start_link(__MODULE__, args, name: via_tuple(id))
  end

  def init([id]) do
    {:ok, %{room_id: id, schedule: nil}, {:continue, :setup}}
  end

  def get_target_temp(room_id) do
    GenServer.call(via_tuple(room_id), :get_target_temp)
  end

  def handle_continue(:setup, state) do
    calendar = Thermox.Calendars.Repo.get(state.room_id)
    {:noreply, %{state | schedule: calendar.schedule}}
  end

  def handle_call(:get_target_temp, _from, state) do
    {_, {h, _, _}} = :calendar.local_time()
    target_temp = Enum.at(state.schedule, h, 0)

    {:reply, {:ok, target_temp}, state}
  end

  defp via_tuple(id) do
    {:via, Registry, {Thermox.Calendars.Registry, id}}
  end
end
