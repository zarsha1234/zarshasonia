defmodule TodoWeb.Live.Index do
  use TodoWeb, :live_view
  alias Todo.{Todo, Repo}
  # alias Todo.Repo
  import TodoWeb.CoreComponents
    # def mount(_params, _session, socket) do
    #   {:ok, socket}
    # end

    def mount(_params,_session, socket) do
    # Initial setup: create a new changeset for the form
    changeset= Todo.changeset(%Todo{},%{})
    {:ok, assign(socket, changeset: changeset)}
  end


  def handle_event("validate", %{"title" => _title, "description" => _description, "status" => _status}=todo_params, socket) do
    changeset =
      %Todo{}
      |> Todo.changeset(todo_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"title" => _title, "description" => _description, "status" => _status}=todo_params, socket) do
    changeset = Todo.changeset(%Todo{}, todo_params)
      case Repo.insert(changeset) do
      {:ok, _todo} ->
        {:noreply, assign(socket, changeset: Todo.changeset(%Todo{},%{}), message: "Todo created successfully!")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
