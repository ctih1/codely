defmodule Codely.Repo.Migrations.CreateSnippets do
  use Ecto.Migration

  def change do
    create table(:snippets) do
      add :real_sample, :string # Human written code sample
      add :ai_sample, :string # AI written code sample
      add :prompt, :string # What prompt was used to generate it

      add :real_sample_source, :string # Where the real code was found
      add :ai_sample_source, :string # Either where the code was found, or what model generated it

      timestamps()
    end

    create unique_index(:snippets, [:real_sample])
  end
end
