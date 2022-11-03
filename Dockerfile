FROM clux/muslrust as builder

RUN rustup update stable \
 && rustup default stable \
 && rustup target add x86_64-unknown-linux-musl \
 && cargo install cargo-deb tomato-toml

FROM alpine:3.16 as runner

COPY --from=builder /root/.cargo/bin/cargo-deb /cargo-deb
COPY --from=builder /root/.cargo/bin/tomato /tomato
COPY /entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
