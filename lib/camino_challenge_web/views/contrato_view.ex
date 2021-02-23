defmodule CaminoChallengeWeb.ContratoView do
  use CaminoChallengeWeb, :view
  alias CaminoChallengeWeb.ContratoView

  def render("index.json", %{contratos: contratos}) do
    %{data: render_many(contratos, ContratoView, "contrato.json")}
  end

  def render("show.json", %{contrato: contrato}) do
    %{data: render_one(contrato, ContratoView, "contrato.json")}
  end

  def render("contrato.json", %{contrato: contrato}) do
    %{
      id: contrato.id,
      file: contrato.file,
      nome: contrato.nome,
      descricao: contrato.descricao,
      data: contrato.data,
      lista_partes: contrato.lista_partes
    }
  end
end
