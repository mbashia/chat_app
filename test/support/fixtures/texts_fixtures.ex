defmodule ChatSystem.TextsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ChatSystem.Texts` context.
  """

  @doc """
  Generate a text.
  """
  def text_fixture(attrs \\ %{}) do
    {:ok, text} =
      attrs
      |> Enum.into(%{
        message: "some message"
      })
      |> ChatSystem.Texts.create_text()

    text
  end
end
