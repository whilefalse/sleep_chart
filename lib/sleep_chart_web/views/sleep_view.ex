defmodule SleepChartWeb.SleepView do
  use SleepChartWeb, :view

  def friendly_date(sleep_date, today) do
    case sleep_date do
      ^today -> "Today"
      _ -> Timex.format!(sleep_date, "{WDfull}, {D} {Mfull}")
    end
  end

  @date_format Application.get_env(:sleep_chart, :date_format)
  def format_date(date) do
    {:ok, date} = Timex.format(date, Application.get_env(:sleep_chart, :date_format))
    date
  end

  def parse_date(string) do
    Timex.parse(string, @date_format)
  end

end
