# Software version. It can be passed by --build-arg on build time.
ARG NODE_VERSION="13.2.0"

# Minimal Node image with Chrome for testing.
FROM node:${NODE_VERSION}-alpine

LABEL maintainer="juanje.ojeda@gmail.com"
LABEL name="node-chrome:${NODE_VERSION}-alpine"
LABEL version="0.1.0"
LABEL version.node=${NODE_VERSION}

# Installs latest Chromium package.
RUN apk add --no-cache \
    libstdc++ \
    chromium \
    harfbuzz \
    nss \
    freetype \
    ttf-freefont

# Run the container as user node
WORKDIR /app
RUN chown node:node /app

USER node
ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/

