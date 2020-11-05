defmodule Thermox.ProcessManager do
  use GenServer
  require Logger
  alias Thermox.Calendars.Server, as: Calendar
  alias Thermox.Controllers.Server, as: Controller

  @threshold 0.5

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    Thermox.Broker.subscribe()
  end

  def handle_info({:temperature_changed, data}, state) do

    {:ok, target_temp} = Calendar.get_target_temp(data.room_id)

    if (target_temp > data.temp + @threshold) do
      Logger.info("Switch on. current_temp=#{data.temp} room_id=#{data.room_id}")
      Controller.switch_on(data.room_id)
    end

    if (target_temp <= data.temp - @threshold) do
      Logger.info("Switch off. current_temp=#{data.temp} room_id=#{data.room_id}")
      Controller.switch_off(data.room_id)
    end

    {:noreply, state}
  end

end
