FROM --platform=${TARGETPLATFORM} debian:stable-slim AS builder

ARG TARGETPLATFORM
ARG TAG

RUN echo "Building image for $TARGETPLATFORM" && \
    apt-get update && apt-get install -y curl bzip2 && \
    ARCH=$(case ${TARGETPLATFORM} in \
        linux/amd64) echo "debian-10-64bit" ;; \
        linux/arm64/v8) echo "debian-stable-arm64" ;; \
        *) echo "debian-10-64bit" ;; \
    esac) && \
    curl -L "https://download.foldingathome.org/releases/beta/fah-client/${ARCH}/release/fah-client_${TAG}-64bit-release.tar.bz2"  | tar xj --strip 1 -C /tmp

FROM --platform=${TARGETPLATFORM} debian:stable-slim
LABEL maintainer="undirectlookable@users.noreply.github.com"
COPY --from=builder /tmp/fah-client /usr/bin/
WORKDIR /var/lib/fah-client
ENTRYPOINT ["/usr/bin/fah-client"]
CMD ["--config=/etc/fah-client/config.xml", "--log=/var/log/fah-client/log.txt", "--log-rotate-dir=/var/log/fah-client/"]