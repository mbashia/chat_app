defmodule ChatSystem.TextsTest do
  use ChatSystem.DataCase

  alias ChatSystem.Texts

  describe "texts" do
    alias ChatSystem.Texts.Text

    import ChatSystem.TextsFixtures

    @invalid_attrs %{message: nil}

    test "list_texts/0 returns all texts" do
      text = text_fixture()
      assert Texts.list_texts() == [text]
    end

    test "get_text!/1 returns the text with given id" do
      text = text_fixture()
      assert Texts.get_text!(text.id) == text
    end

    test "create_text/1 with valid data creates a text" do
      valid_attrs = %{message: "some message"}

      assert {:ok, %Text{} = text} = Texts.create_text(valid_attrs)
      assert text.message == "some message"
    end

    test "create_text/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Texts.create_text(@invalid_attrs)
    end

    test "update_text/2 with valid data updates the text" do
      text = text_fixture()
      update_attrs = %{message: "some updated message"}

      assert {:ok, %Text{} = text} = Texts.update_text(text, update_attrs)
      assert text.message == "some updated message"
    end

    test "update_text/2 with invalid data returns error changeset" do
      text = text_fixture()
      assert {:error, %Ecto.Changeset{}} = Texts.update_text(text, @invalid_attrs)
      assert text == Texts.get_text!(text.id)
    end

    test "delete_text/1 deletes the text" do
      text = text_fixture()
      assert {:ok, %Text{}} = Texts.delete_text(text)
      assert_raise Ecto.NoResultsError, fn -> Texts.get_text!(text.id) end
    end

    test "change_text/1 returns a text changeset" do
      text = text_fixture()
      assert %Ecto.Changeset{} = Texts.change_text(text)
    end
  end
end
