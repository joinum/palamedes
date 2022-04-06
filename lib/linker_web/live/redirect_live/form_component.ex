defmodule LinkerWeb.RedirectLive.FormComponent do
  use LinkerWeb, :live_component

  alias Linker.Shortener

  @impl true
  def update(%{redirect: redirect} = assigns, socket) do
    changeset = Shortener.change_redirect(redirect)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"redirect" => redirect_params}, socket) do
    changeset =
      socket.assigns.redirect
      |> Shortener.change_redirect(redirect_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"redirect" => redirect_params}, socket) do
    save_redirect(socket, socket.assigns.action, redirect_params)
  end

  defp save_redirect(socket, :edit, redirect_params) do
    case Shortener.update_redirect(socket.assigns.redirect, redirect_params) do
      {:ok, _redirect} ->
        {:noreply,
         socket
         |> put_flash(:info, "Redirect updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_redirect(socket, :new, redirect_params) do
    case Shortener.create_redirect(redirect_params) do
      {:ok, _redirect} ->
        {:noreply,
         socket
         |> put_flash(:info, "Redirect created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
