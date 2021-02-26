defmodule CaminoChallengeWeb.Api.ContratoView do
  use CaminoChallengeWeb, :view

  def render("index.json", %{contratos: contratos}) do
    %{data: render_many(contratos, __MODULE__, "contrato_index.json")}
  end

  def render("show.json", %{contrato: contrato}) do
    %{data: render_one(contrato, __MODULE__, "contrato_show.json")}
  end

  def render("contrato_index.json", %{contrato: contrato}) do
    %{
      id: contrato.id,
      nome: contrato.nome,
      descricao: contrato.descricao,
      data: contrato.data,
      partes: %{
        pessoas_fisicas: render_pf(contrato.partes.pessoas_fisicas),
        pessoas_juridicas: render_pj(contrato.partes.pessoas_juridicas)
      },
      arquivo_url: "http://192.168.0.100:4000/uploads/arquivos/" <> contrato.arquivo
    }
  end

  def render("contrato_show.json", %{contrato: contrato}) do
    %{
      id: contrato.id,
      nome: contrato.nome,
      descricao: contrato.descricao,
      data: contrato.data
    }
  end

  def render_pf(pessoas_fisicas) do
    Enum.map(pessoas_fisicas, &pf_json/1)
  end

  def render_pj(pessoas_juridicas) do
    Enum.map(pessoas_juridicas, &pj_json/1)
  end

  def pf_json(pessoa_fisica) do
    %{
      pessoa_id: pessoa_fisica.pessoa_id,
      nome: pessoa_fisica.nome,
      cpf: pessoa_fisica.cpf,
      data_nascimento: pessoa_fisica.data_nascimento
    }
  end

  def pj_json(pessoa_juridica) do
    %{
      pessoa_id: pessoa_juridica.pessoa_id,
      nome: pessoa_juridica.nome,
      cnpj: pessoa_juridica.cnpj
    }
  end

  def endereco_json(endereco) do
    %{
      rua: endereco.rua,
      cep: endereco.cep,
      cidade: endereco.cidade,
      uf: endereco.uf,
      pais: endereco.pais
    }
  end
end
