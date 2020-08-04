defmodule Thermox.Broker do
  @topic :thermox

  def publish(message) do
    Registry.dispatch(Thermox.PubSub.Registry, @topic, fn entries ->
      for {pid, _} <- entries do
        send(pid, message)
      end
    end)
  end

  def subscribe(topic \\ @topic) do
    Registry.register(Thermox.PubSub.Registry, topic, [])
  end
end
