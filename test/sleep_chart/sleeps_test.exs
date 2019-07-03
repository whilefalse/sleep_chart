defmodule SleepChart.SleepsTest do
  use SleepChart.DataCase

  alias SleepChart.Sleeps
  alias SleepChart.Sleeps.Sleep

  @valid_attrs %{date: ~D[2010-04-17], slept: true}
  @invalid_attrs %{date: nil, slept: nil}

  def sleep_fixture(attrs \\ %{}) do
    {:ok, sleep} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Sleeps.create_sleep()

    sleep
  end

  describe "get_sleep_by_date/1" do
    test "sleep with given date exists" do
      sleep = sleep_fixture()
      assert Sleeps.get_sleep_by_date(sleep.date) == sleep
    end

    test "get_sleep_by_date/1 when sleep with given date does not exists" do
      assert Sleeps.get_sleep_by_date(@valid_attrs.date) == nil
    end
  end

  describe "create_sleep/1" do
    test "with valid date" do
      assert {:ok, %Sleep{} = sleep} = Sleeps.create_sleep(@valid_attrs)
      assert sleep.date == ~D[2010-04-17]
      assert sleep.slept == true
    end

    test "with invalid data" do
      assert {:error, %Ecto.Changeset{errors: errors}} = Sleeps.create_sleep(@invalid_attrs)
      assert [{_, [validation: :required]}] = Keyword.get_values(errors, :date)
      assert [{_, [validation: :required]}] = Keyword.get_values(errors, :slept)
    end

    test "with duplicate date" do
      _sleep = sleep_fixture()
      assert {:error, %Ecto.Changeset{errors: errors}} = Sleeps.create_sleep(@valid_attrs)
      [{_, [constraint: :unique, constraint_name: _]}] = Keyword.get_values(errors, :date)
    end
  end

  describe "change_sleep/1" do
    test "returns an Ecto changeset" do
      sleep = sleep_fixture()
      assert %Ecto.Changeset{} = Sleeps.change_sleep(sleep)
    end
  end
end
