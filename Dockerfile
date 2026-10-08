FROM ubuntu:26.04@sha256:f144425ff09be612d6d9ad965196e9cdc23dae1f42110a8a11a3e9a8198759f7

ARG PHIX_VERSION=1.0.5a

RUN apt-get update && apt-get install --yes --no-install-recommends ca-certificates wget unzip

RUN zipname="phix.${PHIX_VERSION}.zip" && \
    wget "http://phix.x10.mx/p64" && \
    wget "http://phix.x10.mx/${zipname}" && \
    mv p64 p && \
    chmod 777 p && \
    mv p /usr/local/bin/p && \
    unzip "${zipname}" -d /usr/local/phix && \
    rm "${zipname}" && \
    mv /usr/local/phix/builtins /usr/local/bin/builtins && \
    cd /usr/local/bin && \
    find "/usr/local/phix" -type f -executable -exec ln -s {} \;

RUN apt-get purge --auto-remove --yes ca-certificates wget unzip && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN p --version

WORKDIR /opt/test-runner
COPY . .
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
