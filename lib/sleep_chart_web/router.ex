defmodule SleepChartWeb.Router do
  use SleepChartWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SleepChartWeb do
    pipe_through :browser

    get "/", SleepController, :index
    get "/:date", SleepController, :show
    put "/:date", SleepController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", SleepChartWeb do
  #   pipe_through :api
  # end
end
