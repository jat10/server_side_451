# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :server_side_451,
  ecto_repos: [ServerSide451.Repo]

# Configures the endpoint
config :server_side_451, ServerSide451Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hZXXhB6Z2DUO6TyhaItbOYcYiRTU44HOGV5M7F0gKQzXuYaPGaZsG/gpPGDXmPec",
  render_errors: [view: ServerSide451Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ServerSide451.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
