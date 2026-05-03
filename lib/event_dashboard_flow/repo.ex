defmodule EventDashboardFlow.Repo do
  use Ecto.Repo,
    otp_app: :event_dashboard_flow,
    adapter: Ecto.Adapters.Postgres
end
