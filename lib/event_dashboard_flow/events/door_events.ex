defmodule EventDashboardFlow.Events.DoorEvents do
  use Ecto.Schema
  import Ecto.Changeset

  schema "door_events" do
    field :event_type, :string
    field :event_data, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(door_events, attrs) do
    door_events
    |> cast(attrs, [:event_type, :event_data])
    |> validate_required([:event_type])
  end
end
