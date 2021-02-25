defmodule CaminoChallenge.Validations do
  def valid_uuid(id) do
    case Ecto.UUID.dump(id) do
      {:ok, _uuid} -> true
      _ -> false
    end
  end

  defp is_date(date) do
    case Date.from_iso8601(date) do
      {:ok, _} -> true
      _ -> false
    end
  end
end
