defmodule EventDashboardFlow.EventsTest do
  use EventDashboardFlow.DataCase

  alias EventDashboardFlow.Events

  describe "door_events" do
    alias EventDashboardFlow.Events.DoorEvents

    import EventDashboardFlow.EventsFixtures

    @invalid_attrs %{event_type: nil, event_data: nil}

    test "list_door_events/0 returns all door_events" do
      door_events = door_events_fixture()
      assert Events.list_door_events() == [door_events]
    end

    test "get_door_events!/1 returns the door_events with given id" do
      door_events = door_events_fixture()
      assert Events.get_door_events!(door_events.id) == door_events
    end

    test "create_door_events/1 with valid data creates a door_events" do
      valid_attrs = %{event_type: "some event_type", event_data: "some event_data"}

      assert {:ok, %DoorEvents{} = door_events} = Events.create_door_events(valid_attrs)
      assert door_events.event_type == "some event_type"
      assert door_events.event_data == "some event_data"
    end

    test "create_door_events/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_door_events(@invalid_attrs)
    end

    test "update_door_events/2 with valid data updates the door_events" do
      door_events = door_events_fixture()
      update_attrs = %{event_type: "some updated event_type", event_data: "some updated event_data"}

      assert {:ok, %DoorEvents{} = door_events} = Events.update_door_events(door_events, update_attrs)
      assert door_events.event_type == "some updated event_type"
      assert door_events.event_data == "some updated event_data"
    end

    test "update_door_events/2 with invalid data returns error changeset" do
      door_events = door_events_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_door_events(door_events, @invalid_attrs)
      assert door_events == Events.get_door_events!(door_events.id)
    end

    test "delete_door_events/1 deletes the door_events" do
      door_events = door_events_fixture()
      assert {:ok, %DoorEvents{}} = Events.delete_door_events(door_events)
      assert_raise Ecto.NoResultsError, fn -> Events.get_door_events!(door_events.id) end
    end

    test "change_door_events/1 returns a door_events changeset" do
      door_events = door_events_fixture()
      assert %Ecto.Changeset{} = Events.change_door_events(door_events)
    end
  end
end
