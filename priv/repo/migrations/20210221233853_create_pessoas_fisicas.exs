defmodule CaminoChallenge.Repo.Migrations.CreatePessoasFisicas do
  use Ecto.Migration

  def change do
    create table(:pessoas_fisicas, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :nome, :string
      add :cpf, :string
      add :data_nascimento, :date

      timestamps()
    end

    create(unique_index(:pessoas_fisicas, [:cpf]))

  end
end
