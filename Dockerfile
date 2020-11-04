ARG NODE_VERSION

FROM node:${NODE_VERSION}

# nginx
RUN apt update
RUN apt install -y nginx
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /api

COPY api/* /api/

# bundle all dependencies
RUN npm install

# bootstrap API server
CMD ["start.sh"]
