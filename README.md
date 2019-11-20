<div align="center">
  <h1>Tweetflood</h1>
  <h3>A twitter API client to for tweetstorm promotions</h3>
  <br>
  <br>
</div>

---

## What does this do?

A tweetstorm is a type of promotion where people need to tweet at someone with
a hashtag, and after certain milestones, things can happen.

This software does not control what happens, but tracks twitter and all the
tweets matching a given text. It then records them all so you can do things
later.

## Requirements

You will need to have `docker` and `docker-compose` installed on your
system. The Docker website has great guides for
[installing docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce)
and for [installing docker-compose](https://docs.docker.com/compose/install/).

## Running

Once you have `docker` and `docker-compose` installed, simply run the following
command to setup the environment (database migrations and seed data):

- `docker-compose run tweetflood ecto.setup`

Then run this command to start everything:

- `docker-compose up`

You can view the site at [`localhost:4000`](http://localhost:4000).

**NOTE** If you make any changes to elixir dependencies or node dependencies,
you will need to rebuild the image with `docker-compose build tweetflood`.
Everything else should be hot code reloaded.

## Production

Master will automatically publish a `system76/tweetflood` docker image. You can
see all the environmental configuration values available at
[`./config/releases.exs`](./config/releases.exs). Make sure to run database
migrations by running `eval "Tweetflood.Release.migrate"`.

## Testing

Just like development, this project can be tested with `docker` and
`docker-compose`. Simply run `docker-compose run tweetflood test`. This will
start all the dependencies, but instead of running the server, run our tests.
