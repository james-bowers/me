defmodule Test.MeWeb.Integration.Account do
  use ExUnit.Case
  use Plug.Test

  alias MeWeb.Router

  @opts Router.init([])

  # @account1_id "7119e5c9-37b5-4fb2-bf42-7981f4ec8d6a"

  test "new anonymous account" do
    conn = conn(:post, "/account", %{})
    conn = Router.call(conn, @opts)

    assert String.contains?(
             conn.resp_body,
             ~s({"description":"A new anonymous account has been created.","content":{"id":")
           )

    assert String.contains?(conn.resp_body, ~s("active":1))
    assert conn.status == 200
  end

  # test "get auth token for a role" do
  #   {:ok, token, full_claims} = Guardian.encode_and_sign(account)
  #   # TODO: require a token header to auth as the person
  #   conn = conn(:get, "/token/#{@role1_id}")
  #   conn = Router.call(conn, @opts)

  #   assert String.contains?(conn.resp_body, ~s("token":)
  # end
end
