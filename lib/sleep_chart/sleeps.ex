defmodule SleepChart.Sleeps do
  @moduledoc """
  The Sleeps context.
  """

  import Ecto.Query, warn: false
  alias SleepChart.Repo

  alias SleepChart.Sleeps.Sleep

  @doc """
  Returns the list of sleeps.

  ## Examples

      iex> list_sleeps()
      [%Sleep{}, ...]

  """
  def list_sleeps do
    Repo.all(Sleep)
  end

  @doc """
  Gets a single sleep.

  Raises `Ecto.NoResultsError` if the Sleep does not exist.

  ## Examples

      iex> get_sleep!(123)
      %Sleep{}

      iex> get_sleep!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sleep!(id), do: Repo.get!(Sleep, id)

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
  Updates a sleep.

  ## Examples

      iex> update_sleep(sleep, %{field: new_value})
      {:ok, %Sleep{}}

      iex> update_sleep(sleep, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sleep(%Sleep{} = sleep, attrs) do
    sleep
    |> Sleep.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Sleep.

  ## Examples

      iex> delete_sleep(sleep)
      {:ok, %Sleep{}}

      iex> delete_sleep(sleep)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sleep(%Sleep{} = sleep) do
    Repo.delete(sleep)
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
