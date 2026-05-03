defmodule EventDashboardFlow.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias EventDashboardFlow.Repo

  alias EventDashboardFlow.Events.DoorEvents

  @doc """
  Returns the list of door_events.

  ## Examples

      iex> list_door_events()
      [%DoorEvents{}, ...]

  """
  def list_door_events do
    Repo.all(DoorEvents)
  end

  @doc """
  Gets a single door_events.

  Raises `Ecto.NoResultsError` if the Door events does not exist.

  ## Examples

      iex> get_door_events!(123)
      %DoorEvents{}

      iex> get_door_events!(456)
      ** (Ecto.NoResultsError)

  """
  def get_door_events!(id), do: Repo.get!(DoorEvents, id)

  @doc """
  Creates a door_events.

  ## Examples

      iex> create_door_events(%{field: value})
      {:ok, %DoorEvents{}}

      iex> create_door_events(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_door_events(attrs \\ %{}) do
    inserted = %DoorEvents{}
              |> DoorEvents.changeset(attrs)
              |> Repo.insert()

    case inserted do 
      {:ok, event} ->
        case event.event_type do
          "ENTRY_DOOR_IS_OPENED" -> EventDashboardFlow.DashboardState.put(:door_open, true)

          "ENTRY_DOOR_IS_SHUT" -> EventDashboardFlow.DashboardState.put(:door_open, false)

          _ -> :ok
        end
        inserted

        _ ->
          inserted
    end
  end

  @doc """
  Updates a door_events.

  ## Examples

      iex> update_door_events(door_events, %{field: new_value})
      {:ok, %DoorEvents{}}

      iex> update_door_events(door_events, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_door_events(%DoorEvents{} = door_events, attrs) do
    door_events
    |> DoorEvents.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a door_events.

  ## Examples

      iex> delete_door_events(door_events)
      {:ok, %DoorEvents{}}

      iex> delete_door_events(door_events)
      {:error, %Ecto.Changeset{}}

  """
  def delete_door_events(%DoorEvents{} = door_events) do
    Repo.delete(door_events)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking door_events changes.

  ## Examples

      iex> change_door_events(door_events)
      %Ecto.Changeset{data: %DoorEvents{}}

  """
  def change_door_events(%DoorEvents{} = door_events, attrs \\ %{}) do
    DoorEvents.changeset(door_events, attrs)
  end
end
