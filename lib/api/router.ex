defmodule Thermox.Api.Router do
  use Thermox.Api.BaseRouter

  get "/ping" do
    version = Application.spec(:thermox, :vsn) |> to_string()
    send_json_resp(conn, 200, %{name: "thermox", version: version})
  end

end
