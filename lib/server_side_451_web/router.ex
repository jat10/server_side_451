defmodule ServerSide451Web.Router do
  use ServerSide451Web, :router

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

  scope "/", ServerSide451Web do
    pipe_through :browser # Use the default browser stack
    get "/", PageController, :index
    get "/get_channel_list", ApiController, :return_available_channels
    get "/register_user", ApiController, :registerUser
    get "/check_user", ApiController, :check_user
    get "/heart_beat", ApiController, :heart_beat

  end

  # Other scopes may use custom stacks.
  # scope "/api", ServerSide451Web do
  #   pipe_through :api
  # end
end
