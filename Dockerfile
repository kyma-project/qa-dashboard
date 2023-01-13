# ---- Base Alpine with Node ----
FROM alpine:3.15.0 AS builder
RUN apk add --update nodejs npm

WORKDIR /app

# Install global dependencies
RUN apk update && \
  apk upgrade && \
  apk add --no-cache curl make

# Set env variables
ENV PRODUCTION true
ENV CI true

COPY . ./
RUN make resolve
RUN make validate
RUN make pull-licenses

RUN make test && make build

# ---- Serve ----
FROM nginxinc/nginx-unprivileged:1.21

# nginx
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 8080
ENTRYPOINT ["nginx", "-g", "daemon off;"]
