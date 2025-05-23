FROM ghcr.io/actions/actions-runner:2.323.0
# for latest release, see https://github.com/actions/runner/releases

USER root

# install curl and jq
RUN apt-get update && apt-get install -y curl jq --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY scripts/entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

USER runner

ENTRYPOINT ["./entrypoint.sh"]
