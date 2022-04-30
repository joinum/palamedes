defmodule LinkerWeb.InfoController do
  use LinkerWeb, :controller

  @app Mix.Project.config()[:app]
  @version Mix.Project.config()[:version]
  @description Mix.Project.config()[:description]
  @git_ref Mix.Project.config()[:git_ref]

  def about(conn, _params) do
    conn
    |> json(%{
      app: @app,
      version: @version,
      description: @description,
      git_ref: String.slice(@git_ref, 0, 8)
    })
  end

  def version(conn, _params) do
    conn
    |> text(@git_ref)
  end
end
