defmodule CaminoChallengeWeb.Api.PessoaFisicaView do
  @moduledoc false
  use CaminoChallengeWeb, :view
  require Logger

  def render("index.json", %{pessoas_fisicas: pessoas_fisicas}) do
    %{data: render_many(pessoas_fisicas, __MODULE__, "pessoa_fisica.json")}
  end

  def render("show.json", %{pessoa_fisica: pessoa_fisica}) do
    %{data: render_one(pessoa_fisica, __MODULE__, "pessoa_fisica.json")}
  end

  def render("pessoa_fisica.json", %{pessoa_fisica: pessoa_fisica}) do
    %{
      id: pessoa_fisica.pessoa_id,
      nome: pessoa_fisica.pessoa.nome,
      tipo: pessoa_fisica.pessoa.type,
      cpf: pessoa_fisica.cpf,
      data_nascimento: pessoa_fisica.data_nascimento
    }
  end
end
