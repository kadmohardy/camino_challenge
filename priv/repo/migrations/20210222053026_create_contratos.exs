defmodule CaminoChallenge.Repo.Migrations.CreateContratos do
  use Ecto.Migration

  def change do
    create table(:contratos, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :file, :string
      add :nome, :string
      add :descricao, :string
      add :data, :date

      timestamps()
    end
  end
end
