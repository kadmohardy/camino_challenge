defmodule CaminoChallenge.Uploaders.Pdf do
  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original]

  # def filename(version, {_file, scope}) do
  #   :crypto.hash(:sha256, "#{scope.id}_#{version}")
  #   |> Base.encode16
  #   |> String.downcase
  # end

  def storage_dir(_version, {_, _}) do
    if Mix.env() == :test do
      "uploads/test"
    else
      "uploads/arquivos"
    end
  end
end
