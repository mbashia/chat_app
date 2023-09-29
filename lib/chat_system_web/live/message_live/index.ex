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

    {:ok,
     socket
     |> assign(:messages, list_messages())
     |> assign(:changeset, changeset)
     |> assign(:user, user)
     |> assign(:users, users)}
  end

  def handle_event("choose", params, socket) do
    IO.inspect(params)
    {:noreply, socket}
  end

  def handle_event("save", %{"message" => message_params}, socket) do
    IO.inspect(message_params)

    new_message =
      message_params
      |> Map.put("sender_id", socket.assigns.user.id)

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
