FROM ruby:3.3.1

RUN bundle config --global frozen 1

WORKDIR /usr/src/app/backend

COPY Gemfile Gemfile.lock ./
RUN bundle lock --add-platform x86_64-linux \
    && bundle install

RUN echo "source /usr/share/bash-completion/completions/git" >> ~/.bashrc

RUN curl -SL https://deb.nodesource.com/setup_20.x | bash \
    && apt-get update \
    && apt-get install -y nodejs sudo lsof vim\
    && npm install -g yarn