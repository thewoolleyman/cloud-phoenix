defmodule CloudPhoenix.Repo.Migrations.CreateWidget do
  use Ecto.Migration

  def change do
    create table(:widgets) do
      add :name, :string

      timestamps()
    end

  end
end
