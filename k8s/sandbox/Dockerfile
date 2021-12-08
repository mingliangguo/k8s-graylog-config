FROM ubuntu:latest

RUN apt-get update && apt-get install software-properties-common -y

RUN apt-get update && apt-get install neovim curl netcat vim jq zsh  -y

RUN sed -i 's/required/sufficient/g' /etc/pam.d/chsh
RUN chsh -s /usr/bin/zsh

ENTRYPOINT ["sleep infinite"]
