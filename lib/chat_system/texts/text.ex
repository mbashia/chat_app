defmodule ChatSystem.Texts.Text do
  use Ecto.Schema
  import Ecto.Changeset

  schema "texts" do
    field :message, :string

    timestamps()
  end

  @doc false
  def changeset(text, attrs) do
    text
    |> cast(attrs, [:message])
    |> validate_required([:message])
  end
end
