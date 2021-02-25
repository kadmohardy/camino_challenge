defmodule CaminoChallenge.Repo.Migrations.UpdateTables do
  use Ecto.Migration

  def change do
    drop table(:enderecos)

    drop table(:pessoas_fisicas)

    drop table(:pessoas_juridicas)

    create table(:pessoas, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :nome, :string
      add :type, :string
      timestamps()
    end

    create table(:pessoas_fisicas, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :cpf, :string
      add :data_nascimento, :date

      add :pessoa_id,
          references(:pessoas,
            on_delete: :nilify_all,
            on_update: :nilify_all,
            type: :uuid
          )

      timestamps()
    end

    create table(:pessoas_juridicas, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :cnpj, :string

      add :pessoa_id,
          references(:pessoas,
            on_delete: :nilify_all,
            on_update: :nilify_all,
            type: :uuid
          )

      timestamps()
    end

    create table(:enderecos, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :pais, :string
      add :uf, :string
      add :cidade, :string
      add :rua, :string
      add :cep, :string

      add :pessoa_juridica_id,
          references(:pessoas_juridicas,
            on_delete: :nilify_all,
            on_update: :nilify_all,
            type: :uuid
          )

      timestamps()
    end

    create(index(:pessoas, [:type]))
    create(unique_index(:pessoas_fisicas, [:cpf]))
    create(unique_index(:pessoas_juridicas, [:cnpj]))
  end
end
