defmodule Todo.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todo" do
    field :status, :boolean, default: false
    field :description, :string
    field :title, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :description, :status])
    |> validate_required([:title, :description, :status])
  end
end
