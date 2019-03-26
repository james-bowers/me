defmodule Test.MeWeb.Integration.SignUp do
  use ExUnit.Case
  use Plug.Test

  alias Test.Support.HTTPHelper

  @valid_body_with_email_and_password %{email: "tester@ticketbuddy.co.uk", password: "password"}
  @valid_body_anonymous %{}

  def run_user_signup_test!(req_body) do

    assert {200, body} = HTTPHelper.post("/person/sign-up", req_body)

    assert %{
      "content" => %{
        "token" => _token,
        "role" => _role,
        "account" => _account,
        "person" => _person
      }
    } = body

    body
  end

  test "a user with email and password can sign up" do
    body = run_user_signup_test!(@valid_body_with_email_and_password)
    assert %{
      "description" => "New user account created",
      "content" => %{
        "email" => _email
      }
    } = body
  end

  test "an anonymous user can sign up" do
    body = run_user_signup_test!(@valid_body_anonymous)
    assert %{
      "description" => "Anonymous account created",
    } = body
  end
end
