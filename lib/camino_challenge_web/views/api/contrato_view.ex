defmodule CaminoChallengeWeb.Api.ContratoView do
  use CaminoChallengeWeb, :view

  def render("index.json", %{contratos: contratos}) do
    %{data: render_many(contratos, __MODULE__, "contrato.json")}
  end

  def render("show.json", %{contrato: contrato}) do
    %{data: render_one(contrato, __MODULE__, "contrato.json")}
  end

  def render("contrato.json", %{contrato: contrato}) do
    %{
      id: contrato.id,
      nome: contrato.nome,
      descricao: contrato.descricao,
      data: contrato.data,
    }
  end
end
