defmodule Thermox.Api.Router do
  use Thermox.Api.BaseRouter

  get "/ping" do
    version = Application.spec(:thermox, :vsn) |> to_string()
    send_json_resp(conn, 200, %{name: "thermox", version: version})
  end

  get "/temperature/:room_id" do
    {room_id, ""} = Integer.parse(room_id)
    {:ok, temp} = Thermox.Rooms.Server.current_temp(room_id)
    send_json_resp(conn, 200, %{room_id: room_id, temp: temp})
  end

end
