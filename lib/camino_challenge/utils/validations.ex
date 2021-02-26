defmodule CaminoChallenge.Validations do
  def valid_uuid?(id) do
    case Ecto.UUID.cast(id) do
      {:ok, _uuid} -> true
      _ -> false
    end
  end

  def is_date?(date) do
    case Date.from_iso8601(date) do
      {:ok, _} -> true
      _ -> false
    end
  end

  def string_to_date(date) do
    case Date.from_iso8601(date) do
      {:ok, data} -> data
      _ -> ~D[2000-01-01]
    end
  end
end
