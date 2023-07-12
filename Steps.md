# Steps to Recreate

This file will cover the steps taken to get this app started from scratch. The hope is to go from empty folder to
a Phoenix LiveView application that can authenticate a user via OIDC (from Google preferred, but Azure AD and/or
AWS Cognito would be a good stretch goal). The results of the app plus this step document should allow for creating
a fresh app in the future.

## Global Prep

These are all of the preliminary steps leading up to starting this exploration. They can be done in any order. These
steps are really getting a flexible development environment configured.

* Install [asdf](https://asdf-vm.com/guide/getting-started.html)
  * Install the latest Erlang and Elixir versions
* Install [Docker Desktop](https://www.docker.com/products/docker-desktop/)
  * Start a Docker postgres instance with the command below

Docker command (remember to change `{path}` to a valid location):

```zsh
docker run -d --name explore_auth -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres \
-e POSTGRES_DB=explore_auth -e  POSTGRES_HOST_AUTH_METHOD=password \
-v {path}/explore_auth:/var/lib/postgresql/data -p 5432:5432 postgres:15.3
```

## Local Prep

These steps are used to generate a bunch of boilerplate necessary to have a "Hello, world!" code base that can be
committed to a repo.

* Create a local folder, open a terminal in that folder and run the following commands there:
  * `asdf local erlang latest` - this will set the folder to run the latest Erlang version
  * `asdf local elixir latest` - this will set the folder to run the latest Elixir version
  * `mix local.hex` - installs Hex for your version of Elixir
  * `mix archive.install hex phx_new` - this will install the Phoenix generator for your version of Elixir
  * `mix phx.new explore_auth` - this will create a standard Phoenix project (using Ecto and LiveView)
* Copy the `.tools-version` file in the parent folder into the `explore_auth` folder so that the repo will know what versions it was built against
* Change directories to the new folder and run:
  * `git init` and commit this to enable version control going forward
  * `mix ecto.create` - to create the DB
  * `mix phx.server` - to run the server (on whatever local port is configured in `/config/dev.exs`; default is 4000)
