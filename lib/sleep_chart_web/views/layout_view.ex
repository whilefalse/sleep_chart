defmodule SleepChartWeb.LayoutView do
  use SleepChartWeb, :view

  def yesterday(date) do
    Date.add date, -1
  end

  def tomorrow(date) do
    Date.add date, 1
  end
end
