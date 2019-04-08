defmodule Test.MeWeb.Smoke.LinkAccountToRole do
  use BowersLib.TestSupport.HTTP, MeWeb.Router

  @person2_id "dc54b524-5da1-4120-9871-a57bc814ba05"

  test "sign up anonymous user and validate token" do
    assert {200, %{"content" => %{"account" => %{"id" => account_id}}}, _headers} =
             post("/account")

    assert {200, link_role_body, _headers} =
             post("/role/link", %{
               account_id: account_id,
               person_id: @person2_id
             })

    assert %{
             "description" => "Account linked to person"
           } = link_role_body
  end
end
