defmodule SleepChart.SleepsTest do
  use SleepChart.DataCase

  alias SleepChart.Sleeps

  describe "sleeps" do
    alias SleepChart.Sleeps.Sleep

    @valid_attrs %{date: ~D[2010-04-17], slept: true}
    @update_attrs %{date: ~D[2011-05-18], slept: false}
    @invalid_attrs %{date: nil, slept: nil}

    def sleep_fixture(attrs \\ %{}) do
      {:ok, sleep} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sleeps.create_sleep()

      sleep
    end

    test "list_sleeps/0 returns all sleeps" do
      sleep = sleep_fixture()
      assert Sleeps.list_sleeps() == [sleep]
    end

    test "get_sleep!/1 returns the sleep with given id" do
      sleep = sleep_fixture()
      assert Sleeps.get_sleep!(sleep.id) == sleep
    end

    test "create_sleep/1 with valid data creates a sleep" do
      assert {:ok, %Sleep{} = sleep} = Sleeps.create_sleep(@valid_attrs)
      assert sleep.date == ~D[2010-04-17]
      assert sleep.slept == true
    end

    test "create_sleep/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sleeps.create_sleep(@invalid_attrs)
    end

    test "update_sleep/2 with valid data updates the sleep" do
      sleep = sleep_fixture()
      assert {:ok, %Sleep{} = sleep} = Sleeps.update_sleep(sleep, @update_attrs)
      assert sleep.date == ~D[2011-05-18]
      assert sleep.slept == false
    end

    test "update_sleep/2 with invalid data returns error changeset" do
      sleep = sleep_fixture()
      assert {:error, %Ecto.Changeset{}} = Sleeps.update_sleep(sleep, @invalid_attrs)
      assert sleep == Sleeps.get_sleep!(sleep.id)
    end

    test "delete_sleep/1 deletes the sleep" do
      sleep = sleep_fixture()
      assert {:ok, %Sleep{}} = Sleeps.delete_sleep(sleep)
      assert_raise Ecto.NoResultsError, fn -> Sleeps.get_sleep!(sleep.id) end
    end

    test "change_sleep/1 returns a sleep changeset" do
      sleep = sleep_fixture()
      assert %Ecto.Changeset{} = Sleeps.change_sleep(sleep)
    end
  end
end
