defmodule CodelyWeb.PageController do
  use CodelyWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
