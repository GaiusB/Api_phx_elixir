# File: lib/time_manager_web/router.ex
defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TimeManagerWeb do
    pipe_through :api

    resources "/user", UserController, except: [:new, :edit]

    scope "/clocks" do
      get "/:userID", ClockController, :index
      post "/:userID", ClockController, :create
    end

    scope "/workingtime" do
      get "/:userID", WorkingTimeController, :index
      get "/:userID/:id", WorkingTimeController, :show
      post "/:userID", WorkingTimeController, :create
      put "/:userID/:id", WorkingTimeController, :update
      delete "/:userID/:id", WorkingTimeController, :delete
    end
  end
end
