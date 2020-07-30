defmodule Thermox.Api.BaseRouter do
  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__)

      use Plug.Router
      use Plug.ErrorHandler

      plug(Plug.Parsers,
        parsers: [:urlencoded, :json, :multipart],
        pass: ["*/*"],
        json_decoder: Jason
      )

      plug(:match)
      plug(:dispatch)

      def json(data) do
        Jason.encode!(data)
      end

      def send_json_resp(conn, status_code), do: send_json_resp(conn, status_code, %{})

      def send_json_resp(conn, status_code, payload) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(status_code, json(payload))
      end
    end
  end
end
