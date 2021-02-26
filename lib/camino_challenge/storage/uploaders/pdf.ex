defmodule CaminoChallenge.Uploaders.Pdf do
  @moduledoc false

  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original]

  def storage_dir(_version, {_, _}) do
    if Mix.env() == :test do
      "uploads/test"
    else
      "uploads/arquivos"
    end
  end
end
