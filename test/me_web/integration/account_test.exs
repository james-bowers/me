defmodule Test.MeWeb.Integration.Account do
  use ExUnit.Case
  use Plug.Test

  alias MeWeb.Router

  @opts Router.init([])

  test "new anonymous account" do
    conn = conn(:post, "/", %{})
    conn = Router.call(conn, @opts)

    assert String.contains?(conn.resp_body, ~s({"description":"A new anonymous account has been created.","content":{"id":"))
    assert conn.status == 200
  end
end