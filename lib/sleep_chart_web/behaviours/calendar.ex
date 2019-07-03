defmodule SleepChartWeb.Behaviours.Calendar do
  @callback today() :: Date.t()
end