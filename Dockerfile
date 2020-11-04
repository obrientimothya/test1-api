ARG NODE_VERSION

FROM node:${NODE_VERSION}

# nginx
RUN apk add --no-cache --update nginx
RUN rm -rf /var/cache/apk/*
RUN rm -rf /root/.cache

WORKDIR /app

# stage app prerequisites
COPY package.json /app/package.json
COPY app.js /app/app.js
COPY config.js /app/config.js
COPY api/routes/version.js /app/api/routes/version.js

# bundle all dependencies
RUN npm install

# bootstrap API server
CMD ["node", "app.js"]
