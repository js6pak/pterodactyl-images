FROM mcr.microsoft.com/dotnet/aspnet:5.0-buster-slim

LABEL author="js6pak"

ENV DEBIAN_FRONTEND noninteractive

RUN     apt update -y \
        && apt upgrade -y \
        && wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
        && dpkg -i packages-microsoft-prod.deb \
        && apt update -y \
        && apt install -y libgdiplus

USER    container
ENV     USER=container HOME=/home/container
WORKDIR /home/container

COPY    ./entrypoint.sh /entrypoint.sh
CMD     ["/bin/bash", "/entrypoint.sh"]
