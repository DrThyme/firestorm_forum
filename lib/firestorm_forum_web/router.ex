defmodule FirestormForumWeb.Router do
  use FirestormForumWeb, :router

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

  scope "/", FirestormForumWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/categories", CategoryController do
      resources "/threads", ThreadController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", FirestormForumWeb do
  #   pipe_through :api
  # end
end
