defmodule Test.MeWeb.Integration.Login do
  use ExUnit.Case
  use Plug.Test

  alias MeWeb.Router

  @opts Router.init([])
  @valid_body %{email: "james@ticketbuddy.co.uk", password: "password"}

  test "a user can login" do
    conn = conn(:post, "/person/login", @valid_body)
    conn = Router.call(conn, @opts)

    assert {200,
            [
              {"cache-control", "max-age=0, private, must-revalidate"},
              {"content-type", "application/json; charset=utf-8"}
            ], _body} = sent_resp(conn)

    assert String.contains?(conn.resp_body, ~s("token":"))
  end
end
