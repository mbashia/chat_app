defmodule ChatSystem.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ChatSystem.Repo,
      # Start the Telemetry supervisor
      ChatSystemWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ChatSystem.PubSub},
      # Start the Endpoint (http/https)
      ChatSystemWeb.Endpoint
      # Start a worker by calling: ChatSystem.Worker.start_link(arg)
      # {ChatSystem.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ChatSystem.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChatSystemWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
