use Mix.Config

# Configure mocks
config :sleep_chart,
  calendar: SleepChartWeb.MockCalendar
# Configure your database
config :sleep_chart, SleepChart.Repo,
  username: "sleep_chart",
  password: "sleep_chart",
  database: "sleep_chart_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sleep_chart, SleepChartWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
