defmodule Codely.Repo do
  use Ecto.Repo,
    otp_app: :codely,
    adapter: Ecto.Adapters.Postgres
end
