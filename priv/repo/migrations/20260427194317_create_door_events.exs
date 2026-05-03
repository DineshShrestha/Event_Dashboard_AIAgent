defmodule EventDashboardFlow.Repo.Migrations.CreateDoorEvents do
  use Ecto.Migration

  def change do
    create table(:door_events) do
      add :event_type, :string
      add :event_data, :string

      timestamps(type: :utc_datetime)
    end
  end
end
