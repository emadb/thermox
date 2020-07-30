defmodule Thermox.Rooms.Schemas.Room do
  use Ecto.Schema

  schema "rooms" do
    field :name, :string
    field :description, :string
    field :gpio, :integer

    timestamps()
  end
end
