# Custom Docker Sandbox template: this config and DevOps tools.
# Build: docker build -t claude-perso sandbox/
# CI builds it on each push to main and publishes ghcr.io/m4nch0t/claude-sandbox.
FROM docker/sandbox-templates:claude-code
USER root
RUN apt-get update \
 && apt-get install -y --no-install-recommends jq shellcheck make gitleaks \
 && rm -rf /var/lib/apt/lists/*
USER agent
# settings.json "env" is not always honored for auto-compact: set it in the image too.
ENV CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=50
# CI passes the commit SHA, so the image matches the commit that triggered it.
ARG CONFIG_REF=main
# HTTPS clone: no SSH key in the image. The memory repo is private, so it is
# not cloned here: that would need a token at build time and put private data
# in a public image. Clone it at runtime (see README).
RUN git clone -q https://github.com/m4nch0t/claude-config-perso.git "$HOME/workspace/claude-config-perso" \
 && git -C "$HOME/workspace/claude-config-perso" reset -q --hard "$CONFIG_REF" \
 && CLAUDE_MEMORY_URL='' sh "$HOME/workspace/claude-config-perso/install.sh"
