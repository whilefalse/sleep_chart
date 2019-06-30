defmodule SleepChart.Repo do
  use Ecto.Repo,
    otp_app: :sleep_chart,
    adapter: Ecto.Adapters.Postgres
end
