defmodule CaminoChallengeWeb.Api.PessoaJuridicaControllerTest do
  use CaminoChallengeWeb.ConnCase

  alias CaminoChallenge.PessoasJuridicas.Entities.PessoaJuridica
  alias CaminoChallenge.PessoasJuridicas.Repositories.PessoaJuridicaRepository

  @create_attrs %{
    cnpj: "some cnpj",
    endereco: "some endereco",
    nome: "some nome"
  }
  @update_attrs %{
    cnpj: "some updated cnpj",
    endereco: "some updated endereco",
    nome: "some updated nome"
  }
  @invalid_attrs %{cnpj: nil, endereco: nil, nome: nil}

  def fixture(:pessoa_juridica) do
    {:ok, pessoa_juridica} = PessoaJuridicaRepository.create_pessoa_juridica(@create_attrs)
    pessoa_juridica
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pessoas_juridicas", %{conn: conn} do
      conn = get(conn, Routes.api_pessoa_juridica_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create pessoa_juridica" do
    test "renders pessoa_juridica when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.api_pessoa_juridica_path(conn, :create), pessoa_juridica: @create_attrs)

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_pessoa_juridica_path(conn, :show, id))

      assert %{
               "id" => id,
               "cnpj" => "some cnpj",
               "endereco" => "some endereco",
               "nome" => "some nome"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(conn, Routes.api_pessoa_juridica_path(conn, :create), pessoa_juridica: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update pessoa_juridica" do
    setup [:create_pessoa_juridica]

    test "renders pessoa_juridica when data is valid", %{
      conn: conn,
      pessoa_juridica: %PessoaJuridica{id: id} = pessoa_juridica
    } do
      conn =
        put(conn, Routes.api_pessoa_juridica_path(conn, :update, pessoa_juridica),
          pessoa_juridica: @update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_pessoa_juridica_path(conn, :show, id))

      assert %{
               "id" => id,
               "cnpj" => "some updated cnpj",
               "endereco" => "some updated endereco",
               "nome" => "some updated nome"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, pessoa_juridica: pessoa_juridica} do
      conn =
        put(conn, Routes.api_pessoa_juridica_path(conn, :update, pessoa_juridica),
          pessoa_juridica: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete pessoa_juridica" do
    setup [:create_pessoa_juridica]

    test "deletes chosen pessoa_juridica", %{conn: conn, pessoa_juridica: pessoa_juridica} do
      conn = delete(conn, Routes.api_pessoa_juridica_path(conn, :delete, pessoa_juridica))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_pessoa_juridica_path(conn, :show, pessoa_juridica))
      end
    end
  end

  defp create_pessoa_juridica(_) do
    pessoa_juridica = fixture(:pessoa_juridica)
    %{pessoa_juridica: pessoa_juridica}
  end
end
