FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y vim vim-gtk tmux git nodejs exuberant-ctags xclip curl
