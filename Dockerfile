# ---- Build stage ----
FROM hexpm/elixir:1.15.7-erlang-26.1.2-debian-bookworm-20231009-slim AS builder

ENV MIX_ENV=prod \
    LANG=C.UTF-8

RUN apt-get update -y && apt-get install -y build-essential git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

# Cache deps separately from app code
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get --only $MIX_ENV
RUN mix deps.compile

# If you use esbuild/tailwind (Phoenix pulls prebuilt binaries, no Node needed)
COPY priv priv
COPY assets assets
COPY lib lib

RUN mix compile
RUN mix assets.deploy
RUN mix release

# ---- Runtime stage ----
FROM debian:bookworm-slim AS app

ENV LANG=C.UTF-8 \
    MIX_ENV=prod \
    PHX_SERVER=true

RUN apt-get update -y && \
    apt-get install -y \
      libstdc++6 \
      libssl3 \
      openssl \
      libncurses5 \
      locales \
      sqlite3 \
      ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN useradd --create-home app

# Create a clean directory specifically for the SQLite database files
RUN mkdir -p /app/data && chown -R app:app /app/data

USER app

COPY --from=builder --chown=app:app /app/_build/prod/rel ./

# Point to the database path inside our writeable folder
ENV DATABASE_PATH=/app/data/database.db

EXPOSE 4000

ENTRYPOINT ["/app/codely/bin/codely"]
CMD ["start"]