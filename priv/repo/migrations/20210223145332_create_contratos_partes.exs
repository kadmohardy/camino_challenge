defmodule CaminoChallenge.Repo.Migrations.CreateContratosPartes do
  use Ecto.Migration

  def change do
    create table(:contratos_partes, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :contrato_id,
          references(:contratos,
            on_delete: :nilify_all,
            on_update: :nilify_all,
            type: :uuid
          )

      add :pessoa_id,
          references(:pessoas,
            on_delete: :nilify_all,
            on_update: :nilify_all,
            type: :uuid
          )
    end

    create index(:contratos_partes, [:contrato_id])
    create index(:contratos_partes, [:pessoa_id])

    create unique_index(:contratos_partes, [:contrato_id, :pessoa_id])
  end
end
