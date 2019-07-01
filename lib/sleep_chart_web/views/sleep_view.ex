defmodule SleepChartWeb.SleepView do
  use SleepChartWeb, :view

  @sleeps_for_treat 5

  def friendly_date(sleep_date, today) do
    case sleep_date do
      ^today -> "Today"
      _ -> sleep_date
    end
  end

  def treat_progress(total_sleeps, slept_this_date) do
    case (rem total_sleeps, @sleeps_for_treat) do
      0 when slept_this_date -> {@sleeps_for_treat, 0, true}
      n -> {n, @sleeps_for_treat - n, false}
    end
  end
end
