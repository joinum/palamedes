defmodule LinkerWeb.HomeLive.Index do
  use LinkerWeb, :live_view

  alias Linker.Shortener
  alias Linker.Shortener.Link

  alias Linker.Accounts.User

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket, layout: false}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply,
      socket
      |> assign(:current_page, :home)
      |> assign(:current_user, %User{})
      |> assign(:links, list_links())}
  end

  @impl true
  def handle_event("increment-clicks", %{"id" => id}, socket) do
    link = Shortener.get_link!(id)
    Shortener.update_link(link, %{clicks: link.clicks + 1})
  end

  defp list_links do
    Shortener.list_links()
  end
end
