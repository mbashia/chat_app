defmodule ChatSystem.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :text, :string
      add :receiver_id, :integer
      add :sender_id, :integer

      timestamps()
    end

    create index(:messages, [:sender_id])
  end
end
