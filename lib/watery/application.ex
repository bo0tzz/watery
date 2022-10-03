defmodule Watery.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Watery.Repo,
      # Start the Telemetry supervisor
      WateryWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Watery.PubSub},
      # Start the Endpoint (http/https)
      WateryWeb.Endpoint
      # Start a worker by calling: Watery.Worker.start_link(arg)
      # {Watery.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Watery.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WateryWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
