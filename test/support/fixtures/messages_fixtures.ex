defmodule ChatSystem.MessagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ChatSystem.Messages` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        text: "some text"
      })
      |> ChatSystem.Messages.create_message()

    message
  end
end
