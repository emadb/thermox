defmodule Thermox.Repo.Migrations.CreateCalendarTable do
  use Ecto.Migration

  def change do
    create table(:calendars) do
      add :room_id, references("rooms")
      add :schedule, {:array, :integer}
      timestamps()
    end
  end
end
