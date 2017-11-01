# README

This is a demo application (Rails 5.1) to show when logging breaks with Passenger OS (greater than 5.1.7).

There are two cases I've noticed:

1. When `rails_stdout_logging` is installed (not a big deal, since it's redundant since Rails 5.0)
2. When `RAILS_LOG_TO_STDOUT` is set in the environment. I don't think this behaviour is expected (test by uncommenting in the Dockerfile)

This is a mostly standard Rails install, with a WelcomeController as a base route/root.

We are using a few tweaks in the `config/nginx.conf.erb`, and `config/logging.rb` is also non-standard. Neither of these seem to affect the logging though.

I have been testing by running the following:

```sh
docker build .
docker run -it --rm -e RAILS_ENV=production -e PORT=3000 -e SECRET_KEY_BASE=asdf -e SECRET_TOKEN=asdf -p 3000:3000 IMAGE_ID
```

and in another terminal:

```sh
curl -v -H "X-Forwarded-Proto: https" http://localhost:3000/
```
