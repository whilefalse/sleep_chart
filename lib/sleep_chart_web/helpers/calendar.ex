defmodule SleepChartWeb.Helpers.Calendar do
  @behaviour SleepChartWeb.Behaviours.Calendar
  @timezone Application.get_env :sleep_chart, :timezone

  @impl SleepChartWeb.Behaviours.Calendar
  def today do
    DateTime.to_date Timex.now(@timezone)
  end
end