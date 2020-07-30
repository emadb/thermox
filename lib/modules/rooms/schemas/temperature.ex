defmodule Thermox.Rooms.Schemas.Temperature do
  use Ecto.Schema

  schema "temperatures" do
    belongs_to :room, Thermox.Rooms.Schemas.Room
    field :value, :float

    timestamps()
  end
end
