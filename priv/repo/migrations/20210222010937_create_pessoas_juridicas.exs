defmodule CaminoChallenge.Repo.Migrations.CreatePessoasJuridicas do
  use Ecto.Migration

  def change do
    create table(:pessoas_juridicas, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :nome, :string
      add :cnpj, :string

      timestamps()
    end

    create(unique_index(:pessoas_juridicas, [:cnpj]))
  end
end
