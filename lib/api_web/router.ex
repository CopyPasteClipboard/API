defmodule ApiWeb.Router do
  use ApiWeb, :router


  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", ApiWeb do
    pipe_through :api

    get "/", PageController, :index
  end
end
