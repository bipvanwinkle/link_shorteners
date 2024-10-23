defmodule LinkMaker.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LinkMakerWeb.Telemetry,
      LinkMaker.Repo,
      {DNSCluster, query: Application.get_env(:link_maker, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LinkMaker.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LinkMaker.Finch},
      # Start a worker by calling: LinkMaker.Worker.start_link(arg)
      # {LinkMaker.Worker, arg},
      # Start to serve requests, typically the last entry
      LinkMakerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LinkMaker.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LinkMakerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
