FROM mono:6-slim

LABEL author="js6pak"

RUN useradd -d /home/container -m container && \
    apt-get update && \
    apt-get install -y --no-install-recommends iproute2 curl gpg

# Install .NET Core
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg && \
    mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ && \
    curl https://packages.microsoft.com/config/debian/9/prod.list --output /etc/apt/sources.list.d/microsoft-prod.list && \
    chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg && \
    chown root:root /etc/apt/sources.list.d/microsoft-prod.list && \
    apt-get update && \
    apt-get install -y apt-transport-https && \
    apt-get update && \
    apt-get install -y dotnet-runtime-3.1

USER container
ENV USER=container HOME=/home/container DOTNET_BUNDLE_EXTRACT_BASE_DIR=/home/container/.cache
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
