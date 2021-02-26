defmodule CaminoChallenge.Contratos.Entities.Upload do
  @moduledoc """
    Module relativo a entidade de Upload que é representa o arquivo do tipo
    pdf anexado ao contrato.
  """
  use Ecto.Schema
  import Ecto.Changeset
  use Arc.Definition
  use Arc.Ecto.Definition
  require Logger
  alias CaminoChallenge.Contratos.Entities.Contrato
  alias CaminoChallenge.Contratos.Entities.Upload

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "uploads" do
    field :arquivo, CaminoChallenge.Uploaders.Pdf.Type
    field :filename, :string
    field :content_type, :string
    field :hash, :string
    field :size, :integer

    belongs_to :contrato, Contrato,
      foreign_key: :contrato_id,
      type: :binary_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(%Upload{} = upload, attrs) do
    attrs = rename_to_unique(attrs)

    upload
    |> cast(attrs, [:arquivo, :filename, :content_type, :size])
    |> validate_required([:arquivo, :filename, :content_type])
    |> validate_number(:size, greater_than: 0)
    |> validate_length(:hash, is: 64)
  end

  defp rename_to_unique(
         %{
           "filename" => _filename,
           "content_type" => content_type,
           "arquivo" => %Plug.Upload{filename: name, content_type: content_type} = arquivo
         } = attrs
       ) do
    type = Enum.at(String.split(content_type, "/"), 1)

    encrypyted_name =
      :crypto.hash(:sha256, "#{:os.system_time()}" <> name)
      |> Base.encode16()
      |> String.downcase()

    arquivo = %Plug.Upload{arquivo | filename: encrypyted_name <> "." <> type}

    %{attrs | "arquivo" => arquivo, "filename" => encrypyted_name <> "." <> type}
  end
end
