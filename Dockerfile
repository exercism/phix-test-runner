FROM ubuntu:26.04@sha256:f3d28607ddd78734bb7f71f117f3c6706c666b8b76cbff7c9ff6e5718d46ff64

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
