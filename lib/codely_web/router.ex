defmodule CodelyWeb.Router do
  use CodelyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {CodelyWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CodelyWeb do
    pipe_through :browser

    live "/", SelectionView.Index, :index
  end

end
