defmodule LinkerWeb.Router do
  use LinkerWeb, :router

  import LinkerWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LinkerWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LinkerWeb do
    pipe_through :browser

    live "/", HomeLive.Index, :index

    get "/:slug", ShortnerController, :show

    get "/_version", InfoController, :version
  end

  # Other scopes may use custom stacks.
  scope "/api", LinkerWeb do
    pipe_through :api

    get "/", InfoController, :about
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LinkerWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", LinkerWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", LinkerWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :logged_in, on_mount: [{LinkerWeb.Hooks, :current_user}] do
      live "/admin/", LinkLive.Index, :index
      live "/admin/:id/edit", LinkLive.Index, :edit
      live "/admin/new", LinkLive.Index, :new
      live "/form/", FormLive.Index, :index
      live "/form/:id/edit", FormLive.Index, :edit
      live "/form/new", FormLive.Index, :new
      live "/redirect/", RedirectLive.Index, :index
      live "/redirect/:id/edit", RedirectLive.Index, :edit
      live "/redirect/new", RedirectLive.Index, :new
      live "/accounts/", UserLive.Index, :index
      live "/accounts/:id/edit", UserLive.Index, :edit
      live "/accounts/new", UserLive.Index, :new
    end

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", LinkerWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
