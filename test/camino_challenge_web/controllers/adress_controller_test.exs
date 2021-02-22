defmodule CaminoChallengeWeb.AdressControllerTest do
  use CaminoChallengeWeb.ConnCase

  alias CaminoChallenge.PessoasJuridicas
  alias CaminoChallenge.PessoasJuridicas.Adress

  @create_attrs %{
    cep: "some cep",
    cidade: "some cidade",
    pais: "some pais",
    rua: "some rua",
    uf: "some uf"
  }
  @update_attrs %{
    cep: "some updated cep",
    cidade: "some updated cidade",
    pais: "some updated pais",
    rua: "some updated rua",
    uf: "some updated uf"
  }
  @invalid_attrs %{cep: nil, cidade: nil, pais: nil, rua: nil, uf: nil}

  def fixture(:adress) do
    {:ok, adress} = PessoasJuridicas.create_adress(@create_attrs)
    adress
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all adresses", %{conn: conn} do
      conn = get(conn, Routes.adress_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create adress" do
    test "renders adress when data is valid", %{conn: conn} do
      conn = post(conn, Routes.adress_path(conn, :create), adress: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.adress_path(conn, :show, id))

      assert %{
               "id" => id,
               "cep" => "some cep",
               "cidade" => "some cidade",
               "pais" => "some pais",
               "rua" => "some rua",
               "uf" => "some uf"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.adress_path(conn, :create), adress: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update adress" do
    setup [:create_adress]

    test "renders adress when data is valid", %{conn: conn, adress: %Adress{id: id} = adress} do
      conn = put(conn, Routes.adress_path(conn, :update, adress), adress: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.adress_path(conn, :show, id))

      assert %{
               "id" => id,
               "cep" => "some updated cep",
               "cidade" => "some updated cidade",
               "pais" => "some updated pais",
               "rua" => "some updated rua",
               "uf" => "some updated uf"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, adress: adress} do
      conn = put(conn, Routes.adress_path(conn, :update, adress), adress: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete adress" do
    setup [:create_adress]

    test "deletes chosen adress", %{conn: conn, adress: adress} do
      conn = delete(conn, Routes.adress_path(conn, :delete, adress))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.adress_path(conn, :show, adress))
      end
    end
  end

  defp create_adress(_) do
    adress = fixture(:adress)
    %{adress: adress}
  end
end
