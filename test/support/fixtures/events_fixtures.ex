defmodule EventDashboardFlow.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EventDashboardFlow.Events` context.
  """

  @doc """
  Generate a door_events.
  """
  def door_events_fixture(attrs \\ %{}) do
    {:ok, door_events} =
      attrs
      |> Enum.into(%{
        event_data: "some event_data",
        event_type: "some event_type"
      })
      |> EventDashboardFlow.Events.create_door_events()

    door_events
  end
end
