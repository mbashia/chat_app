defmodule ChatSystem.Repo.Migrations.CreateTexts do
  use Ecto.Migration

  def change do
    create table(:texts) do
      add :message, :string

      timestamps()
    end
  end
end
