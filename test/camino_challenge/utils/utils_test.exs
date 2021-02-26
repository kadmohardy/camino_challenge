defmodule CaminoChallenge.Pessoas.Repositories.UtilsTest do
  use CaminoChallenge.DataCase
  alias CaminoChallenge.Validations

  require Logger

  describe "pessoas" do
    alias CaminoChallenge.Pessoas.Entities.Pessoa

    test "test valid_uuid?/1 with valid uuid" do
      assert Validations.valid_uuid?("a326ccad-9ae1-4fc6-940c-690661e37403") == true
    end

    test "test valid_uuid?/1 with invalid uuid" do
      assert Validations.valid_uuid?("aaaaa") == false
    end
  end
end
