defmodule Test.MeWeb.Integration.Account do
  use BowersLib.TestSupport.HTTP, MeWeb.Router

  @valid_body %{}

  test "an account can be created" do
    assert {200, body, _headers} = post("/account", @valid_body)

    assert %{
             "content" => %{
               "account" => %{
                 "id" => _id,
                 "active" => 1
               }
             }
           } = body
  end
end
