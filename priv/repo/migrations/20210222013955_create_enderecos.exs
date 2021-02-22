defmodule CaminoChallenge.Repo.Migrations.CreateeEnderecos do
  use Ecto.Migration

  def change do
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
  end
end
