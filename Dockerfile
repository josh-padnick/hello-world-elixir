FROM ubuntu:18.04

LABEL maintainer="Josh Padnick"

# Elixir requires UTF-8
ENV LANG C.UTF-8

# update and install some software requirements
RUN apt-get update && apt-get upgrade -y && apt-get install -y apt-utils build-essential git wget

# download and install Erlang package
RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
    && dpkg -i erlang-solutions_1.0_all.deb \
    && apt-get update \
    && apt-get install -y esl-erlang \
    && rm erlang-solutions_1.0_all.deb

# Install elixir
RUN apt-get install elixir    

# Install hex (Elixir package manager) and rebar (Erlang build tool)
RUN mix local.hex --force \
    && mix local.rebar --force \
    && mix hex.info

# # Place the app in /app
COPY ./hello /app
WORKDIR /app

# Listen on port 4000
EXPOSE 4000

# Required by Phoenix Framework
ENV PORT 4000
ENV MIX_ENV prod

# Compile the entire project
RUN mix compile

# TODO: Fix this warning
# [error] `inotify-tools` is needed to run `file_system` for your system, check https://github.com/rvoicilas/inotify-tools/wiki for more information about how to install it. If it's already installed but not be found, appoint executable file with `config.exs` or `FILESYSTEM_FSINOTIFY_EXECUTABLE_FILE` env.
# [warn] Could not start Phoenix live-reload because we cannot listen to the file system.
# You don't need to worry! This is an optional feature used during development to
# refresh your browser when you save files and it does not affect production.

# Run the web app
CMD ["mix", "phx.server"]