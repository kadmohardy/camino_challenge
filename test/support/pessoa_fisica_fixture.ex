defmodule CaminoChallenge.PessoaFisicaFixture do
  def valid_pessoa_fisica,
    do: %{
      cpf: "12345678910",
      data_nascimento: ~D[2010-04-17],
      nome: "some nome"
    }

  def invalid_pessoa_fisica, do: %{cpf: "12345678910", data_nascimento: "nil", nome: "nil"}

  def invalid_date_pessoa_fisica,
    do: %{cpf: "12345678910", data_nascimento: "nil", nome: "some name"}
end
