defmodule SleepChartWeb.SleepController do
  use SleepChartWeb, :controller

  alias SleepChart.Sleeps
  alias SleepChart.Sleeps.Sleep

  def index(conn, _params) do
    sleeps = Sleeps.list_sleeps()
    render(conn, "index.html", sleeps: sleeps)
  end

  def new(conn, _params) do
    changeset = Sleeps.change_sleep(%Sleep{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sleep" => sleep_params}) do
    case Sleeps.create_sleep(sleep_params) do
      {:ok, sleep} ->
        conn
        |> put_flash(:info, "Sleep created successfully.")
        |> redirect(to: Routes.sleep_path(conn, :show, sleep))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sleep = Sleeps.get_sleep!(id)
    render(conn, "show.html", sleep: sleep)
  end

  def edit(conn, %{"id" => id}) do
    sleep = Sleeps.get_sleep!(id)
    changeset = Sleeps.change_sleep(sleep)
    render(conn, "edit.html", sleep: sleep, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sleep" => sleep_params}) do
    sleep = Sleeps.get_sleep!(id)

    case Sleeps.update_sleep(sleep, sleep_params) do
      {:ok, sleep} ->
        conn
        |> put_flash(:info, "Sleep updated successfully.")
        |> redirect(to: Routes.sleep_path(conn, :show, sleep))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sleep: sleep, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sleep = Sleeps.get_sleep!(id)
    {:ok, _sleep} = Sleeps.delete_sleep(sleep)

    conn
    |> put_flash(:info, "Sleep deleted successfully.")
    |> redirect(to: Routes.sleep_path(conn, :index))
  end
end
