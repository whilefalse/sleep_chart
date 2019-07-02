defmodule SleepChartWeb.SleepController do
  use SleepChartWeb, :controller
  alias SleepChart.Sleeps
  alias SleepChart.Sleeps.Sleep

  plug :parse_date when action in [:show, :create]
  plug :get_today

  @timezone Application.get_env(:sleep_chart, :timezone)
  @sleeps_for_treat Application.get_env(:sleep_chart, :sleeps_for_treat)

  def index(%Plug.Conn{assigns: %{today: today}} = conn, _params) do
    redirect(conn, to: Routes.sleep_path(conn, :show, today))
  end

  def show(%Plug.Conn{assigns: %{date: date}} = conn, _params) do
    case Sleeps.get_sleep_by_date(date) do
      sleep = %Sleep{} -> render(conn, "show.html",
        sleep: sleep,
        treat_progress: Sleeps.treat_progress(date, @sleeps_for_treat, sleep.slept))
      nil -> render(conn, "new.html", changeset: Sleeps.change_sleep(%Sleep{date: date}))
    end
  end

  def create(%Plug.Conn{assigns: %{date: date}} = conn, %{"sleep" => sleep_params}) do
    slept = case sleep_params do
      %{"slept" => _} -> true
      _ -> false
    end
    params = %{date: date, slept: slept}

    case Sleeps.create_sleep(params) do
      {:ok, _} ->
        redirect(conn, to: Routes.sleep_path(conn, :show, date))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp parse_date(%Plug.Conn{params: %{"date" => date}} = conn, _opts) do
    case SleepChartWeb.SleepView.parse_date(date) do
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

  defimpl Phoenix.Param, for: Date do
    def to_param(%Date{} = date) do
      SleepChartWeb.SleepView.format_date(date)
    end
  end

end
