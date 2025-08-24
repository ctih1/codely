defmodule Codely.Repo.Migrations.RenameAiSamlpeToAiSample do
  use Ecto.Migration

  def change do
    rename table(:snippets), :ai_samlpe, to: :ai_sample
  end
end
