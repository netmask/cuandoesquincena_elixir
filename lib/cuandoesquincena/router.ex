defmodule Cuandoesquincena.Router do
  use Plug.Router


  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug Plug.Static, at: "/", from: "/Users/netmask/Projects/personal/cuandoesquincena/public"
  plug :match
  plug :dispatch
  plug Plug.Logger


  get "/api" do
    put_resp_content_type(conn, "application/json") |>
      send_resp(200, Poison.encode!(%{
                seconds_until_payday: Cuandoesquincena.Calculator.seconds_until,
                silly_message: Cuandoesquincena.Silly.clasic_random_message,
                is_today: Cuandoesquincena.Calculator.is_today?}))
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
