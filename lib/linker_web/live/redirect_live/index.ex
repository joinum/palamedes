defmodule LinkerWeb.RedirectLive.Index do
  use LinkerWeb, :live_view

  alias Linker.Shortener
  alias Linker.Shortener.Redirect

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :redirects, list_redirects())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply,
     socket
     |> assign(:current_page, :redirects)
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Redirect")
    |> assign(:redirect, Shortener.get_redirect!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Redirect")
    |> assign(:redirect, %Redirect{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Redirects")
    |> assign(:redirect, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    redirect = Shortener.get_redirect!(id)
    {:ok, _} = Shortener.delete_redirect(redirect)

    {:noreply, assign(socket, :redirects, list_redirects())}
  end

  defp list_redirects do
    Shortener.list_redirects()
  end
end
