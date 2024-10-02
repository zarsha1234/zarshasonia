defmodule TodoWeb.Live.View do
  use TodoWeb, :live_view
  alias Todo.{Repo,Todo}

  def handle_params(%{"id" => id}, _uri, socket) do
    todo = Repo.get!(Todo, id)
    socket = assign(socket, todo: todo)
    {:noreply, socket}
  end


end
