defmodule Thermox.Calendars.Repo do
  alias Thermox.Calendars.Schemas.Calendar

  def get(room_id) do
    Thermox.Calendars.Schemas.Calendar
    |> Thermox.Repo.get_by(room_id: room_id)
  end
end
