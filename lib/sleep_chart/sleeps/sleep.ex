defmodule SleepChart.Sleeps.Sleep do
  use Ecto.Schema
  import Ecto.Changeset
  import SleepChartWeb.Gettext

  schema "sleeps" do
    field :date, :date
    field :slept, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(sleep, attrs) do
    sleep
    |> cast(attrs, [:date, :slept])
    |> validate_required([:date, :slept])
    |> unique_constraint(:date, [
      message: dgettext("errors", "You've already recorded a sleep for this date.")])
  end

end
