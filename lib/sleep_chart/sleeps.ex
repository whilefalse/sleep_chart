defmodule SleepChart.Sleeps do
  @moduledoc """
  The Sleeps context.
  """

  import Ecto.Query, warn: false
  alias SleepChart.Repo
  alias SleepChart.Sleeps.Sleep

  @sleeps_for_treat Application.get_env(:sleep_chart, :sleeps_for_treat)

  @doc """
  Gets a single sleep.

  Raises `Ecto.NoResultsError` if the Sleep does not exist.

  ## Examples

      iex> get_sleep!("2019-06-10"})
      %Sleep{}

      iex> get_sleep!("1970-01-01")
      nil

  """
  def get_sleep_by_date(%Date{} = date) do
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

  @doc """
  Returns information about the progress towards a treat

  ## Examples
      iex> treat_progress(~D[2019-01-01], true)
      { 2, 3, false }
  """
  def treat_progress(%Date{} = date, slept_this_date) do
    total_sleeps = Repo.aggregate(
      (from s in Sleep, where: s.date <= ^date and s.slept == true), :count, :slept)

    case (rem total_sleeps, @sleeps_for_treat) do
      0 when slept_this_date -> {@sleeps_for_treat, 0, true}
      n -> {n, @sleeps_for_treat - n, false}
    end
  end

end
