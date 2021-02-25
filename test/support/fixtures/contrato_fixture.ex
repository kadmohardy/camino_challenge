defmodule CaminoChallenge.Fixtures.ContratoFixture do
  def valid_contrato,
    do: %{
      data: ~D[2010-04-17],
      descricao: "some descricao",
      file: "some file",
      lista_partes: "some lista_partes",
      nome: "some nome"
    }

  def invalid_pessoa_fisica,
    do: %{data: nil, descricao: nil, file: nil, lista_partes: nil, nome: nil}

  def invalid_date_pessoa_fisica,
    do: %{cpf: "12345678910", data_nascimento: "nil", nome: "some name"}
end
