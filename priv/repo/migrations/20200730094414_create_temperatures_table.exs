defmodule Thermox.Repo.Migrations.CreateTemperaturesTable do
  use Ecto.Migration

  def change do
    create table(:temperatures) do
      add :room_id, references("rooms")
      add :date, :utc_datetime_usec
      add :value, :float
      timestamps()
    end
  end
end
