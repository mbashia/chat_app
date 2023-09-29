defmodule ChatSystemWeb.MessageLive.Index do
  use ChatSystemWeb, :live_view

  alias ChatSystem.Messages
  alias ChatSystem.Messages.Message
  alias ChatSystem.Accounts

  @impl true
  def mount(_params, session, socket) do
    changeset = Messages.change_message(%Message{})
    user = Accounts.get_user_by_session_token(session["user_token"])
    IO.inspect(user.id)
    users = Accounts.list_users()
    my_messages = Messages.my_messages(user.id)

    {:ok,
     socket
     |> assign(:messages, list_messages())
     |> assign(:changeset, changeset)
     |> assign(:user, user)
     |> assign(:users, users)
     |> assign(:messages, my_messages)}
  end

  def handle_event("choose", %{"id" => id}, socket) do
    new_id = String.to_integer(id)

    {:noreply,
     socket
     |> assign(:receiver_id, new_id)}
  end

  def handle_event("save", %{"message" => message_params}, socket) do
    new_message =
      message_params
      |> Map.put("sender_id", socket.assigns.user.id)
      |> Map.put("receiver_id", socket.assigns.receiver_id)

    IO.inspect(new_message)

    case Messages.create_message(new_message) do
      {:ok, _message} ->
        {:noreply,
         socket
         |> put_flash(:info, "Message created successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end

    {:noreply, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Message")
    |> assign(:message, Messages.get_message!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Message")
    |> assign(:message, %Message{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Messages")
    |> assign(:message, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    message = Messages.get_message!(id)
    {:ok, _} = Messages.delete_message(message)

    {:noreply, assign(socket, :messages, list_messages())}
  end

  defp list_messages do
    Messages.list_messages()
  end
end
