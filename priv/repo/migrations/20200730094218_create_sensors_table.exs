defmodule Thermox.Repo.Migrations.CreateRoomsTable do
  use Ecto.Migration

  def change do
    create table("rooms") do
      add :name, :string
      add :description, :string
      add :gpio, :integer

      timestamps()
    end
  end
end
