defmodule ChatSystem.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChatSystem.Accounts.User

  schema "messages" do
    field :text, :string
    field :receiver_id, :integer
    belongs_to :user, User, foreign_key: :sender_id

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:text, :sender_id, :receiver_id])
    |> validate_required([:text, :sender_id, :receiver_id])
  end
end
