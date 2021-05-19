FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /hello_app
WORKDIR /hello_app
COPY Gemfile /hello_app/Gemfile
COPY Gemfile.lock /hello_app/Gemfile.lock
RUN bundle install
COPY . /hello_app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

