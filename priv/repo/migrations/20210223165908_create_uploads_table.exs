defmodule CaminoChallenge.Repo.Migrations.CreateUploadsTable do
  use Ecto.Migration

  def change do
    create table(:uploads, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :arquivo, :string
      add :filename, :string
      add :size, :integer
      add :content_type, :string
      add :hash, :string

      add :contrato_id,
          references(:contratos,
            on_delete: :nilify_all,
            on_update: :nilify_all,
            type: :uuid
          )

      timestamps()
    end

    create index(:uploads, [:hash])
  end
end
