defmodule Codely.Snippets do
  import Ecto.Query, warn: false
  alias Codely.Repo
  alias Codely.Snippets.Snippet

  def list_snippets do
    Repo.all(Snippet)
  end

  def get_snippet!(id), do: Repo.get!(Snippet, id)

  def create_snippet(attrs \\ %{}) do
    %Snippet{}
    |> Snippet.changeset(attrs)
    |> Repo.insert()
  end

  def random_snippet do
    query = from s in Snippet, order_by: fragment("RANDOM()"), limit: 1
    Repo.one(query)
  end
end
