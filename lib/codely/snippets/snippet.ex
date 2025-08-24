defmodule Codely.Snippets.Snippet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "snippets" do
    field :real_sample, :string       # Human written code sample
    field :ai_sample, :string         # AI written code sample
    field :prompt, :string            # Prompt used to generate it

    field :real_sample_source, :string # Where the real code was found
    field :ai_sample_source, :string   # Either source or model

    timestamps()
  end

  @doc false
  def changeset(snippet, attrs) do
    snippet
    |> cast(attrs, [
      :real_sample,
      :ai_sample,
      :prompt,
      :real_sample_source,
      :ai_sample_source
    ])
    |> validate_required([:real_sample, :ai_sample, :prompt])
    |> unique_constraint(:real_sample)
  end
end
