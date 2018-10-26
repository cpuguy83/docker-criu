FROM buildpack-deps AS build
ARG CRIU_VERSION=3.6
RUN apt-get update && apt-get install -y \
	curl \
	libnet-dev \
	libprotobuf-c0-dev \
	libprotobuf-dev \
	libnl-3-dev \
	libcap-dev \
	protobuf-compiler \
	protobuf-c-compiler \
	python-protobuf \
	&& mkdir -p /usr/src/criu \
	&& curl -sSL https://github.com/checkpoint-restore/criu/archive/v${CRIU_VERSION}.tar.gz | tar -C /usr/src/criu/ -xz --strip-components=1 \
	&& cd /usr/src/criu \
	&& make \
	&& make PREFIX=/build/ install-criu

FROM scratch
COPY --from=build /build /build
