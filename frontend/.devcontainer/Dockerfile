FROM node:22

RUN echo "source /usr/share/bash-completion/completions/git" >> ~/.bashrc

RUN apt-get update \
    && apt-get install -y sudo lsof