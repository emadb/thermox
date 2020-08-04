defmodule Thermox.Calendars.Schemas.Calendar do
  use Ecto.Schema

  schema "calendars" do
    field :room_id, :integer
    field :schedule, {:array, :integer}
    timestamps()
  end
end
