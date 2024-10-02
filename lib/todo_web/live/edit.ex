defmodule TodoWeb.Live.Edit do
  use TodoWeb, :live_view
  alias Todo.{Repo,Todo}

    def mount(%{"id" => id}, _session, socket) do
      todo = Repo.get!(Todo, id)

      form=
        Todo.changeset(%Todo{},%{})
        |> to_form()

      {:ok, assign(socket, form: form, todo: todo)}
    end

    def handle_event("validate_product", %{"title" => _title, "description" => _description, "status" => _status}=todo_params, socket) do
      form =
        Todo.changeset(socket.assigns.todo, todo_params)
        |> Map.put(:action, :validate)
        |> to_form()

      {:noreply, assign(socket, form: form)}
      end

      def handle_event("save_todo", %{"title" => _title, "description" => _description, "status" => _status}=todo_params, socket) do
        changeset=Todo.changeset(socket.assigns.todo,todo_params)
        socket =
          case Repo.update(changeset) do
            {:ok, %Todo{} = todo} ->
              put_flash(socket, :info, "Todo ID #{todo.id} updated!")

            {:error, %Ecto.Changeset{} = changeset} ->
              form = to_form(changeset)

              socket
              |> assign(form: form)
              |> put_flash(:error, "Invalid data!")
          end

        {:noreply, socket}
      end


end
