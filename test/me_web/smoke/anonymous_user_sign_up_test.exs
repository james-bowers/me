defmodule Test.MeWeb.Smoke.AnonymousUserSignUp do
  use BowersLib.TestSupport.HTTP, MeWeb.Router

  test "sign up anonymous user and validate token" do
    assert {200, sign_up_body, _headers} = post("/person/sign-up")

    assert {200, validate_token_body, _headers} =
             post("/role/validate", %{token: sign_up_body["content"]["token"]})
  end
end
