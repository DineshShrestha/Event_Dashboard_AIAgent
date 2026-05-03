defmodule EventDashboardFlow.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      EventDashboardFlowWeb.Telemetry,
      EventDashboardFlow.Repo,
      {DNSCluster, query: Application.get_env(:event_dashboard_flow, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: EventDashboardFlow.PubSub},
      EventDashboardFlow.DashboardState,

      # Start the Finch HTTP client for sending emails
      {Finch, name: EventDashboardFlow.Finch},
      # Start a worker by calling: EventDashboardFlow.Worker.start_link(arg)
      # {EventDashboardFlow.Worker, arg},
      # Start to serve requests, typically the last entry
      EventDashboardFlowWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EventDashboardFlow.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EventDashboardFlowWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
