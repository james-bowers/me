defmodule Test.MeWeb.Integration.Status do
  use ExBowers.TestSupport.HTTP, MeWeb.Router

  test "/status" do
    assert {200,
            %{
              "status" => "ok"
            },
            [
              {"cache-control", "max-age=0, private, must-revalidate"},
              {"content-type", "text/plain; charset=utf-8"}
            ]} = get("/status")
  end
end
