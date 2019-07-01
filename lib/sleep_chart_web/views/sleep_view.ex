defmodule SleepChartWeb.SleepView do
  use SleepChartWeb, :view

  def friendly_date(sleep_date, today) do
    case sleep_date do
      ^today -> "Today"
      _ -> sleep_date
    end
  end
end
