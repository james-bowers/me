defmodule Test.MeWeb.Smoke.AnonymousUserSignUp do
  use ExUnit.Case

  alias Test.Support.HTTPHelper

  test "sign up anonymous user and validate token" do
    assert {200, sign_up_body} = HTTPHelper.post("/person/sign-up")

    assert {200, validate_token_body} =
             HTTPHelper.post("/role/validate", %{token: sign_up_body["content"]["token"]})
  end
end
