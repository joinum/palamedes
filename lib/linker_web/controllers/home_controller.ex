defmodule LinkerWeb.HomeController do
  use LinkerWeb, :controller

  alias Linker.Shortener

  def index(conn, _params) do
    conn
    |> put_layout(false)
    |> assign(:links, list_links())
    |> render("index.html")
  end

  defp list_links do
    Shortener.list_links()
  end
end
