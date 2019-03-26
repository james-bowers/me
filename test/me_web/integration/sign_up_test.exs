defmodule Test.MeWeb.Integration.SignUp do
  use ExUnit.Case
  use Plug.Test

  alias MeWeb.Router

  @opts Router.init([])
  @valid_body_with_email_and_password %{email: "tester@ticketbuddy.co.uk", password: "password"}
  @valid_body_anonymous %{}

  def run_user_signup_test(req_body) do
    conn = conn(:post, "/person/sign-up", req_body)
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

    conn
  end

  test "a user with email and password can sign up" do
    conn = run_user_signup_test(@valid_body_with_email_and_password)
    assert String.contains?(conn.resp_body, ~s("email":{))
    assert String.contains?(conn.resp_body, ~s(New user account created))
  end

  test "an anonymous user can sign up" do
    conn = run_user_signup_test(@valid_body_anonymous)
    assert String.contains?(conn.resp_body, ~s(Anonymous account created))
  end
end
