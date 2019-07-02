# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sleep_chart,
  ecto_repos: [SleepChart.Repo]

# Configures the endpoint
config :sleep_chart, SleepChartWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7FM3jJACy3VkEgn7YA/hd2QAX2ATGfofz3U27J4/PpSMbJIMq1+08K76eCdrqqgT",
  render_errors: [view: SleepChartWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SleepChart.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
