# cf_phoenix - Cloud Foundry Phoenix Elixir

Example of running a Phoenix Elixir app on Pivotal Cloud Foundry (PWS/Pivotal Web Services)
and Heroku

# PWS/CF

* Uses https://github.com/HashNuke/heroku-buildpack-elixir.git custom buildpack
* Compiles static files
* Postgres database (elephantsql) service works (must manually provision)
* Requires manual `cf set-env` of `CF_PHOENIX_SECRET_KEY_BASE`
* Continuous Integration autodeploy via Buildkite
* See repo tags for incremental steps taken to get it all working

## Heroku

* Requires manual set of env var `CF_PHOENIX_SECRET_KEY_BASE`
* `heroku git:remote -a cf-phoenix`
* `heroku buildpacks:set https://github.com/HashNuke/heroku-buildpack-elixir`
* `heroku buildpacks:add https://github.com/gjaldon/heroku-buildpack-phoenix-static`
* `git push heroku master`
