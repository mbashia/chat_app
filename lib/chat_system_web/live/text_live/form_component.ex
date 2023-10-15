defmodule ChatSystemWeb.TextLive.FormComponent do
  use ChatSystemWeb, :live_component

  alias ChatSystem.Texts

  @impl true
  def update(%{text: text} = assigns, socket) do
    changeset = Texts.change_text(text)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"text" => text_params}, socket) do
    changeset =
      socket.assigns.text
      |> Texts.change_text(text_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"text" => text_params}, socket) do
    save_text(socket, socket.assigns.action, text_params)
  end

  defp save_text(socket, :edit, text_params) do
    case Texts.update_text(socket.assigns.text, text_params) do
      {:ok, _text} ->
        {:noreply,
         socket
         |> put_flash(:info, "Text updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_text(socket, :new, text_params) do
    case Texts.create_text(text_params) do
      {:ok, _text} ->
        {:noreply,
         socket
         |> put_flash(:info, "Text created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
