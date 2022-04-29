defmodule LinkerWeb.LinkLive.FormComponent do
  use LinkerWeb, :live_component

  alias Linker.Shortener

  @impl true
  def update(%{link: link} = assigns, socket) do
    changeset = Shortener.change_link(link)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"link" => link_params}, socket) do
    changeset =
      socket.assigns.link
      |> Shortener.change_link(link_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"link" => link_params}, socket) do
    link_params =
      link_params
      |> Map.put("clicks", 0)
      |> Map.put("index", Enum.count(Shortener.list_links()) + 1)

    save_link(socket, socket.assigns.action, link_params)
  end

  defp save_link(socket, :edit, link_params) do
    case Shortener.update_link(socket.assigns.link, link_params) do
      {:ok, _link} ->
        {:noreply,
         socket
         |> put_flash(:info, "Link updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_link(socket, :new, link_params) do
    case Shortener.create_link(link_params) do
      {:ok, _link} ->
        {:noreply,
         socket
         |> put_flash(:info, "Link created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
