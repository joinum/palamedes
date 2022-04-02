defmodule LinkerWeb.FormLive.Index do
  use LinkerWeb, :live_view

  alias Linker.Shortener
  alias Linker.Shortener.Form

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :forms, list_forms())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Form")
    |> assign(:form, Shortener.get_form!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Form")
    |> assign(:form, %Form{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Forms")
    |> assign(:form, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    form = Shortener.get_form!(id)
    {:ok, _} = Shortener.delete_form(form)

    {:noreply, assign(socket, :forms, list_forms())}
  end

  defp list_forms do
    Shortener.list_forms()
  end
end
