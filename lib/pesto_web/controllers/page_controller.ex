defmodule PestoWeb.PageController do
  use PestoWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)

    # if you want to redirect somewhere else do this
    # redirect(conn, to: ~p"/guess")
  end
end
