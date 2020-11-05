defmodule Thermox.Controllers.Server do
  use GenServer

  def start_link([id] = args) do
    GenServer.start_link(__MODULE__, args, name: via_tuple(id))
  end

  def switch_on(room_id) do
    GenServer.call(via_tuple(room_id), :switch_on)
  end

  def switch_off(room_id) do
    GenServer.call(via_tuple(room_id), :switch_off)
  end

  def init([id]) do
    {:ok, %{room_id: id, status: :off}}
  end

  def handle_call(:switch_on, _from, state) do
    {:reply, :ok, %{ state | status: :on }}
  end

  def handle_call(:switch_off, _from, state) do
    {:reply, :ok, %{ state | status: :off }}
  end

  defp via_tuple(id) do
    {:via, Registry, {Thermox.Controllers.Registry, id}}
  end
end
