defmodule Test.MeWeb.Integration.SignUp do
  use ExUnit.Case
  use Plug.Test

  alias MeWeb.Router

  @opts Router.init([])
  @valid_body %{email: "tester@ticketbuddy.co.uk", password: "password"}

  test "a user can sign up" do
    conn = conn(:post, "/person/sign-up", @valid_body)
    conn = Router.call(conn, @opts)

    assert {200,
            [
              {"cache-control", "max-age=0, private, must-revalidate"},
              {"content-type", "application/json; charset=utf-8"}
            ], _body} = sent_resp(conn)

    assert String.contains?(conn.resp_body, ~s("token":"))
    assert String.contains?(conn.resp_body, ~s("role":{))
    assert String.contains?(conn.resp_body, ~s("account":{))
    assert String.contains?(conn.resp_body, ~s("person":{))
    assert String.contains?(conn.resp_body, ~s("email":{))
  end
end
