# Demo Sinatra Dockerize

Instructions on how to Dockerize a simple Sinatra application

## Table of Contents

  - [Build the docker image](#build-the-docker-image)
    - [Create the Dockerfile](#create-the-dockerfile)
    - [Build and run the container](#build-and-run-the-container)

## Build the docker image

### Create the Dockerfile

A Dockerfile is a text file that contains all the commands to builds an image. Docker can build images automatically by reading the instructions from a Dockerfile.

Navigate to the root directory and create the file.

```sh
$ touch Dockerfile
```

Docker provides [official Ruby images](https://github.com/docker-library/ruby/tree/995719add69339b78bd8cde46183b4902b761add) and we are going to use Version 2.6.5 as our parent image.

Open Dockerfile and add the following lines:

```ruby
# creates a layer from the Ruby 2.6.5 Docker image
FROM ruby:2.6.5-stretch

# install the GNU C compiler and GNU C++ compiler
RUN apt-get update -qq && apt-get install -y build-essential

# setup the directory for the build context
ENV APP_HOME /demo-sinatra-dockerize
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

#adds files from current directory
ADD Gemfile* $APP_HOME/
RUN bundle install --without development test

ADD . $APP_HOME

EXPOSE 4567

CMD ["ruby", "app.rb"]
```

For deployment purposes, we include the RUN bundle install --without development test line, as we don't need our development dependencies for that.

The EXPOSE instruction indicates the ports on which a container listens for connections. If there is a common, traditional port for your application, you should use it.

Execute the following command to see the most recently created images.

```sh
$ docker images
```

### Build and run the container

Run the build command to build the image with the dockerfile.  

```sh
$ docker build . -t demo-sinatra-dockernize
```

Whenenver you update the dockerfile, you need to run the command.

Now that we have our image, let’s run it!

```sh
$ docker run -p 4567:4567 demo-sinatra-dockerize
```
Go to http://localhost:4567/ to see it running.

Run the following command to see a list of running containers
```sh
$ docker ps
```