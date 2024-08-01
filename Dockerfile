FROM ubuntu:24.04

ARG PHIX_VERSION=1.0.5a

RUN apt update && apt install -y wget unzip

RUN zipname="phix.${PHIX_VERSION}.zip" && \
    wget "http://phix.x10.mx/p64" && \
    wget "http://phix.x10.mx/${zipname}" && \
    mv p64 p && \
    chmod 777 p && \
    mv p /usr/local/bin/p && \
    unzip "${zipname}" -d /usr/local/phix && \
    mv /usr/local/phix/builtins /usr/local/bin/builtins && \
    cd /usr/local/bin && \
    find "/usr/local/phix" -type f -executable -exec ln -s {} \; && \
    echo "done?"

RUN p --version

# install packages required to run the tests
#RUN apk add --no-cache jq coreutils

WORKDIR /opt/test-runner
COPY . .
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
