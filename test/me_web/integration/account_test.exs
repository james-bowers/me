defmodule Test.MeWeb.Integration.Account do
  use ExUnit.Case
  use Plug.Test

  alias MeWeb.Router

  @opts Router.init([])

  test "new anonymous account" do
    conn = conn(:post, "/account", %{})
    conn = Router.call(conn, @opts)

    assert String.contains?(
             conn.resp_body,
             ~s({"description":"A new anonymous account has been created.","content":{"token":")
           )

    assert String.contains?(
             conn.resp_body,
             ~s("account":{"id":)
           )

    assert String.contains?(conn.resp_body, ~s("active":1))
    assert conn.status == 200
  end
end
