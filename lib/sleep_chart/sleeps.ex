defmodule SleepChart.Sleeps do
  @moduledoc """
  The Sleeps context.
  """

  import Ecto.Query, warn: false
  alias SleepChart.Repo

  alias SleepChart.Sleeps.Sleep

  @doc """
  Returns the current day in given timezone
  """
  def today(timezone) do
    DateTime.to_date Timex.now(timezone)
  end

  @doc """
  Gets a single sleep.

  Raises `Ecto.NoResultsError` if the Sleep does not exist.

  ## Examples

      iex> get_sleep!("2019-06-10"})
      %Sleep{}

      iex> get_sleep!("1970-01-01")
      nil

  """
  def get_sleep_by_date(date) do
    Repo.one(
      from s in Sleep,
      where: s.date == ^date)
  end

  @doc """
  Creates a sleep.

  ## Examples

      iex> create_sleep(%{field: value})
      {:ok, %Sleep{}}

      iex> create_sleep(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sleep(attrs \\ %{}) do
    %Sleep{}
    |> Sleep.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sleep changes.

  ## Examples

      iex> change_sleep(sleep)
      %Ecto.Changeset{source: %Sleep{}}

  """
  def change_sleep(%Sleep{} = sleep) do
    Sleep.changeset(sleep, %{})
  end
end
