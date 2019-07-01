defmodule SleepChartWeb.SleepController do
  use SleepChartWeb, :controller
  alias SleepChart.Sleeps
  alias SleepChart.Sleeps.Sleep

  plug :parse_date when action in [:show, :create]
  plug :get_today

  @date_format "{YYYY}-{0M}-{0D}"
  @timezone "Europe/London"

  def index(%Plug.Conn{assigns: %{today: today}} = conn, _params) do
    {:ok, date} = Timex.format(today, @date_format)
    redirect(conn, to: Routes.sleep_path(conn, :show, date))
  end

  def create(%Plug.Conn{assigns: %{date: date}} = conn, %{"sleep" => sleep_params}) do
    params = %{date: date, slept: sleep_params["slept"]}
    case Sleeps.create_sleep(params) do
      {:ok, sleep} ->
        render(conn, "show.html", sleep: sleep)
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(%Plug.Conn{assigns: %{date: date}} = conn, _) do
    case Sleeps.get_sleep_by_date(date) do
      sleep = %Sleep{} -> render(conn, "show.html", sleep: sleep)
      nil -> render(conn, "new.html", changeset: Sleeps.change_sleep(%Sleep{date: date}))
    end
  end

  defp parse_date(%Plug.Conn{params: %{"date" => date}} = conn, opts \\ []) do
    case Timex.parse(date, @date_format) do
      {:ok, parsed} -> assign(conn, :date, NaiveDateTime.to_date(parsed))
      {:error, _} ->
        conn
        |> put_status(:not_found)
        |> put_view(SleepChartWeb.ErrorView)
        |> render(:"404")
    end
  end

  defp get_today(conn, _opts) do
    assign(conn, :today, Sleeps.today @timezone)
  end
end
