defmodule EventDashboardFlow.DashboardState do
    use GenServer
    def start_link(_opts) do
        GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
    end

    def put(name, value) do
        GenServer.cast(__MODULE__, {:put, name, value})
    end

    def get_status do
        GenServer.call(__MODULE__, :get_status)
    end

    def init(_) do
        {:ok, %{door_open: nil, door_open_changed: nil, dynamic_flags: %{}}}
    end

    def handle_cast({:put, :door_open, value}, state) do
        now = DateTime.utc_now() |> DateTime.to_iso8601()

        new_state = state
                        |> Map.put(:door_open, value)
                        |> Map.put(:door_open_changed, now)
    {:noreply, new_state}
    end

    def handle_call(:get_status, _from, state) do
        {:reply, state, state}
    end
end