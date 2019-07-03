defmodule SleepChartWeb.SleepController do
  use SleepChartWeb, :controller
  alias SleepChart.Sleeps
  alias SleepChart.Sleeps.Sleep
  alias SleepChartWeb.Helpers.Date, as: DateHelper

  plug :parse_date_slug when action in [:show, :create]
  plug :get_today

  def index(%Plug.Conn{assigns: %{today: today}} = conn, _params) do
    redirect(conn, to: Routes.sleep_path(conn, :show, today))
  end

  def show(%Plug.Conn{assigns: %{date: date}} = conn, _params) do
    case Sleeps.get_sleep_by_date(date) do
      sleep = %Sleep{} -> render(conn, "show.html",
        sleep: sleep,
        treat_progress: Sleeps.treat_progress(date, sleep.slept))
      nil -> render(conn, "new.html", changeset: Sleeps.change_sleep(%Sleep{date: date}))
    end
  end

  def create(%Plug.Conn{assigns: %{date: date}} = conn, %{"sleep" => sleep_params}) do
    params = %{date: date, slept: Map.has_key?(sleep_params, "slept")}

    case Sleeps.create_sleep(params) do
      {:ok, _} ->
        redirect(conn, to: Routes.sleep_path(conn, :show, date))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # Helper plugs
  defp parse_date_slug(%Plug.Conn{params: %{"date" => date}} = conn, _opts) do
    case DateHelper.parse_slug(date) do
      {:ok, parsed} -> assign(conn, :date, parsed)
      {:error, _} ->
        conn
        |> put_status(:not_found)
        |> put_view(SleepChartWeb.ErrorView)
        |> render(:"404")
        |> halt
    end
  end

  defp get_today(conn, _opts) do
    assign(conn, :today, DateHelper.today)
  end
end
