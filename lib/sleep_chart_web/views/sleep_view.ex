defmodule SleepChartWeb.SleepView do
  use SleepChartWeb, :view

  def friendly_date(sleep_date, today) do
    case sleep_date do
      ^today -> "Today"
      _ -> Timex.format!(sleep_date, "{WDfull}, {D} {Mfull}")
    end
  end
end
