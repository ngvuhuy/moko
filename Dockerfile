FROM rust:1.94-bookworm

# 1. Install Jean's Linux dependencies
RUN apt-get update && apt-get install -y \
    curl build-essential libwebkit2gtk-4.1-dev librsvg2-dev \
    patchelf libayatana-appindicator3-dev libssl-dev libgtk-3-dev

# 2. Install NVM and Node.js v22
ENV NVM_DIR /root/.nvm
ENV NODE_VERSION 24

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# 3. Add Node and NVM to PATH manually for Docker persistence
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# 4. Install Bun
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/root/.bun/bin:${PATH}"

ENV RUST_LOG=info
WORKDIR /app
