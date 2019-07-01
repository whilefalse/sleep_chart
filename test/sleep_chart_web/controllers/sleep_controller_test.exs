defmodule SleepChartWeb.SleepControllerTest do
  use SleepChartWeb.ConnCase

  alias SleepChart.Sleeps

  @create_attrs %{date: ~D[2010-04-17], slept: true}
  @update_attrs %{date: ~D[2011-05-18], slept: false}
  @invalid_attrs %{date: nil, slept: nil}

  def fixture(:sleep) do
    {:ok, sleep} = Sleeps.create_sleep(@create_attrs)
    sleep
  end

  describe "index" do
    test "lists all sleeps", %{conn: conn} do
      conn = get(conn, Routes.sleep_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Sleeps"
    end
  end

  describe "new sleep" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.sleep_path(conn, :new))
      assert html_response(conn, 200) =~ "New Sleep"
    end
  end

  describe "create sleep" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.sleep_path(conn, :create), sleep: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.sleep_path(conn, :show, id)

      conn = get(conn, Routes.sleep_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Sleep"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.sleep_path(conn, :create), sleep: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Sleep"
    end
  end

  describe "edit sleep" do
    setup [:create_sleep]

    test "renders form for editing chosen sleep", %{conn: conn, sleep: sleep} do
      conn = get(conn, Routes.sleep_path(conn, :edit, sleep))
      assert html_response(conn, 200) =~ "Edit Sleep"
    end
  end

  describe "update sleep" do
    setup [:create_sleep]

    test "redirects when data is valid", %{conn: conn, sleep: sleep} do
      conn = put(conn, Routes.sleep_path(conn, :update, sleep), sleep: @update_attrs)
      assert redirected_to(conn) == Routes.sleep_path(conn, :show, sleep)

      conn = get(conn, Routes.sleep_path(conn, :show, sleep))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, sleep: sleep} do
      conn = put(conn, Routes.sleep_path(conn, :update, sleep), sleep: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Sleep"
    end
  end

  describe "delete sleep" do
    setup [:create_sleep]

    test "deletes chosen sleep", %{conn: conn, sleep: sleep} do
      conn = delete(conn, Routes.sleep_path(conn, :delete, sleep))
      assert redirected_to(conn) == Routes.sleep_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.sleep_path(conn, :show, sleep))
      end
    end
  end

  defp create_sleep(_) do
    sleep = fixture(:sleep)
    {:ok, sleep: sleep}
  end
end
