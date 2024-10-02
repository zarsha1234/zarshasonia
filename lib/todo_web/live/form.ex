defmodule TodoWeb.Live.Form do
  alias Todo.Repo
  use TodoWeb, :live_view
  import TodoWeb.CoreComponents
  import Ecto.Query, only: [from: 1]
  alias Todo.Todo

  def mount(_params, _session, socket) do
    query = from t in Todo
    todo = Repo.all(query)
    socket = stream(socket, :todo, todo )
  {:ok, socket}
  end

 # Handling the delete event
 def handle_event("delete", %{"id" => id}, socket) do
  form=Repo.get(Todo, id)

      Repo.delete(form) # Delete the todo from the database
      todos = Repo.all(Todo) # Reload all todos after deletion
      {:noreply, assign(socket, todos: todos) |> put_flash(:info, "Todo deleted successfully.")}

  end
end
