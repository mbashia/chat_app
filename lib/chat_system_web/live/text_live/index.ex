defmodule ChatSystemWeb.TextLive.Index do
  use ChatSystemWeb, :live_view

  alias ChatSystem.Texts
  alias ChatSystem.Texts.Text

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Texts.subscribe()
    end

    {:ok, assign(socket, :texts, list_texts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  def handle_info({:message_created, text}, socket) do
    {:noreply,
     socket
     |> assign(:texts, [text | socket.assigns.texts])}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Text")
    |> assign(:text, Texts.get_text!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Text")
    |> assign(:text, %Text{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Texts")
    |> assign(:text, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    text = Texts.get_text!(id)
    {:ok, _} = Texts.delete_text(text)

    {:noreply, assign(socket, :texts, list_texts())}
  end

  defp list_texts do
    Texts.list_texts()
  end
end
