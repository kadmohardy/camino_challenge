defmodule CaminoChallenge.Pessoas.Repositories.UtilsTest do
  use CaminoChallenge.DataCase
  alias CaminoChallenge.Validations

  describe "pessoas" do
    test "test valid_uuid?/1 with valid uuid" do
      assert Validations.valid_uuid?("a326ccad-9ae1-4fc6-940c-690661e37403") == true
    end

    test "test valid_uuid?/1 with invalid uuid" do
      assert Validations.valid_uuid?("aaaaa") == false
    end

    test "test is_date?/1 with valid date" do
      assert Validations.is_date?("2020-11-14") == true
    end

    test "test is_date?/1 with invalid date" do
      assert Validations.is_date?("2020-11-99") == false
    end

    test "test string_to_date/1 with valid date" do
      assert ~D[2020-11-14] == Validations.string_to_date("2020-11-14")
    end

    test "test string_to_date/1 with invalid date" do
      assert ~D[2000-01-01] == Validations.string_to_date("2020-11-44")
    end
  end
end
