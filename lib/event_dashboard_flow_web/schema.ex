defmodule EventDashboardFlowWeb.Schema do
  use Absinthe.Schema

  object :door_event do
    field :id, :id
    field :event_type, :string
    field :event_data, :string
  end

  object :dashboard_status do
    field :door_open, :boolean
    field :door_open_changed, :string
  end

  query do
    field :get_dashboard_status, :dashboard_status do
      resolve(fn _, _, _ ->
        {:ok, EventDashboardFlow.DashboardState.get_status()}
      end)
    end
  end

  mutation do
    field :create_door_event, :door_event do
      arg(:event_type, non_null(:string))
      arg(:event_data, :string)

      resolve(fn _, args, _ ->
        EventDashboardFlow.Events.create_door_events(args)
      end)
    end
  end

  subscription do
    field :dashboard_update, :dashboard_status do
      config(fn _, _ ->
        {:ok, topic: "dashboard"}
      end)
    end
  end
end
