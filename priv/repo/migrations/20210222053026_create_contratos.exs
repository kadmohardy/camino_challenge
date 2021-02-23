defmodule CaminoChallenge.Repo.Migrations.CreateContratos do
  use Ecto.Migration

  def change do
    create table(:contratos, primary_key: false) do
      add :file, :string
      add :nome, :string
      add :descricao, :string
      add :data, :date
      add :lista_partes, :string

      timestamps()
    end
  end
end
