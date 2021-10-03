FROM mcr.microsoft.com/dotnet/aspnet:6.0-bullseye-slim

LABEL author="js6pak"

ENV DEBIAN_FRONTEND noninteractive

RUN     apt update -y \
        && apt upgrade -y \
        && apt install -y libgdiplus

USER    container
ENV     USER=container HOME=/home/container
WORKDIR /home/container

COPY    ./entrypoint.sh /entrypoint.sh
CMD     ["/bin/bash", "/entrypoint.sh"]
