defmodule Thermox.ProcessManager do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    Thermox.Broker.subscribe()
  end

  def handle_info({:temperature_changed, data}, state) do

    # {:ok, target_temp} = Calendar.get_target_temp(data.room_id)
    # if (target_temp > data.temp) do
    #   Controller.switch_on(data.room_id)
    # end

    # if (target_temp <= data.temp) do
    #   Controller.switch_off(data.room_id)
    # end

    {:noreply, state}
  end

end
