FROM docker.io/alpine:3.15.4 as builder

ARG ARCH

RUN apk update && apk add curl binutils build-base


RUN if [ ${ARCH} == "amd64" ]; then curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain stable-x86_64-unknown-linux-musl -y; fi

RUN if [ ${ARCH} == "arm64" ]; then curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain stable-aarch64-unknown-linux-musl -y; fi

WORKDIR /app

COPY ./Cargo.toml /app/
COPY ./src/ /app/src/

ENV PATH=/root/.cargo/bin:${PATH}

RUN cargo build --release && \
  mv ./target/release/segfaulter /usr/local/bin

FROM docker.io/alpine:3.15.4

RUN adduser -D app

COPY --from=builder  /usr/local/bin/segfaulter /usr/local/bin/

CMD ["segfaulter"]