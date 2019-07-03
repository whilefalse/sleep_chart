defmodule SleepChartWeb.Helpers.Date do
  @date_slug_format "{YYYY}-{0M}-{0D}"
  @timezone Application.get_env :sleep_chart, :timezone

  def format_slug(date) do
    {:ok, date} = Timex.format(date, @date_slug_format)
    date
  end

  def parse_slug(string) do
    with {:ok, parsed} <- Timex.parse(string, @date_slug_format) do
      {:ok, NaiveDateTime.to_date parsed}
    end
  end

  def today do
    DateTime.to_date Timex.now(@timezone)
  end

  defimpl Phoenix.Param, for: Date do
    def to_param(%Date{} = date) do
      SleepChartWeb.Helpers.Date.format_slug(date)
    end
  end
end