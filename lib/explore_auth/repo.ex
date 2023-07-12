defmodule ExploreAuth.Repo do
  use Ecto.Repo,
    otp_app: :explore_auth,
    adapter: Ecto.Adapters.Postgres
end
