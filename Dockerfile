FROM ubuntu:16.04

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update
RUN apt-get install -y vim vim-gtk tmux git nodejs npm exuberant-ctags xclip curl silversearcher-ag zsh

ENV LANG en_US.UTF-8
ENV TERM=screen-256color

# Create required directory
RUN mkdir /project
RUN mkdir /root/.ssh

# Copy vim configuration
COPY ./vim /root/vim
RUN mkdir /root/vim/tmp
RUN mkdir /root/vim/cache
RUN ln -s /root/vim/vimrc /root/.vimrc

# Copy TMUX configuration
COPY tmux/conf /root/.tmux.conf

# Copy ZSH configuration
COPY zshrc /root/.zshrc

# Copy git configuration
COPY git/gitconfig /root/.gitconfig
COPY git/gitignore /root/.gitignore

# Update nodejs version
RUN npm install -g n
RUN n latest
RUN mkdir /root/.bin
RUN ln -s /root/nodejs/node /root/.bin/node
RUN ln -s /root/nodejs/npm /root/.bin/npm

# Setup ctags and tagsgen
RUN npm install -g tagsgen
COPY ./ctags /root/.ctags
COPY ./tagsgen.json /root/.tagsgen.json

# Install vim bundles
RUN cd /root && vim +BundleInstall +qall

# Run TMUX
WORKDIR /project
CMD tmux
