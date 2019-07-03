defmodule SleepChartWeb.SleepControllerTest do
  use SleepChartWeb.ConnCase
  import Mox
  alias SleepChart.Sleeps

  setup :setup_mocks
  setup :verify_on_exit!

  @default_date ~D[2010-04-17]
  @default_date_string "2010-04-17"

  def fixture(type, date \\ @default_date)
  def fixture(:slept, date) do
    {:ok, sleep} = Sleeps.create_sleep(%{date: date, slept: true})
    sleep
  end
  def fixture(:did_not_sleep, date) do
    {:ok, sleep} = Sleeps.create_sleep(%{date: date, slept: false})
    sleep
  end

  def setup_mocks(_context) do
    stub(SleepChartWeb.MockCalendar, :today, fn -> @default_date end)
    :ok
  end

  describe "index" do
    test "redirects to today", %{conn: conn} do

      conn = get(conn, Routes.sleep_path(conn, :index))
      assert redirected_to(conn) =~ @default_date_string
    end
  end

  describe "show" do
    test "when sleep with given date does not exist", %{conn: conn} do
      conn = get(conn, Routes.sleep_path(conn, :show, @default_date))
      response = html_response(conn, 200)

      # Buttons should be visible for creating a new sleep
      assert response =~ "<form"
      assert response =~ "I slept all night"
      assert response =~ "I woke up"
    end

    test "when slept that day", %{conn: conn} do
      sleep = fixture(:slept)
      conn = get(conn, Routes.sleep_path(conn, :show, sleep.date))

      assert html_response(conn, 200) =~ "You slept last night!"
    end

    test "when did not sleep that day", %{conn: conn} do
      sleep = fixture(:did_not_sleep)
      conn = get(conn, Routes.sleep_path(conn, :show, sleep.date))

      assert html_response(conn, 200) =~ "Don't worry, keep trying!"
    end
    
    test "when a treat is due", %{conn: conn} do
      Enum.each([
        {:slept, ~D[2019-01-01]},
        {:slept, ~D[2019-01-02]},
        {:slept, ~D[2019-01-03]},
        {:slept, ~D[2019-01-04]},
        # Non-sleeps don't break the chain
        {:did_not_sleep, ~D[2019-01-05]},
        {:slept, ~D[2019-01-06]},
      ], fn {type, date} -> fixture(type, date) end)

      conn = get(conn, Routes.sleep_path(conn, :show, ~D[2019-01-06]))
      assert html_response(conn, 200) =~ "Time for a treat"
    end

    test "returns 404 with an invalid date", %{conn: conn} do
      conn = get(conn, Routes.sleep_path(conn, :show, "foo"))
      assert html_response(conn, 404)
    end
  end

  describe "create sleep" do
    def test_valid(%Plug.Conn{} = conn, %{} = params, expected) do
      conn = put(conn, Routes.sleep_path(conn, :create, @default_date), %{sleep: params})
      assert redirected_to(conn) == Routes.sleep_path(conn, :show, @default_date)

      conn = get(conn, Routes.sleep_path(conn, :show, @default_date))
      response = html_response(conn, 200)
      assert response =~ "Today"
      assert response =~ expected
    end

    test "redirects to show when data is valid (slept)", %{conn: conn} do
      test_valid conn, %{slept: true}, "You slept last night!"
    end
    
    test "redirects to show when the data is valid (not slept)", %{conn: conn} do
      test_valid conn, %{}, "Don't worry, keep trying!"
    end

    test "renders error when sleep already exists", %{conn: conn} do
      fixture(:slept)
      conn = put(conn, Routes.sleep_path(conn, :create, @default_date), %{sleep: %{}})

      assert html_response(conn, 200) =~ "already recorded a sleep for this date"
    end

    test "returns 404 with an invalid date", %{conn: conn} do
      conn = put(conn, Routes.sleep_path(conn, :create, "foo"))
      assert html_response(conn, 404)
    end
  end
end
