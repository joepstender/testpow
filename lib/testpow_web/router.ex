defmodule TestpowWeb.Router do
  use TestpowWeb, :router
  use Pow.Phoenix.Router

  use Pow.Extension.Phoenix.Router,
    extensions: [PowInvitation]

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

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
  end

  scope "/", TestpowWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/tenants", TenantController, only: [:show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", TestpowWeb do
  #   pipe_through :api
  # end
end
