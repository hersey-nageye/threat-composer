# ---- Build Stage ----
FROM node:23-alpine AS builder
WORKDIR /app

COPY package*.json yarn.lock ./
RUN yarn install

COPY . .
RUN yarn build

# ---- Production Stage ----
FROM node:23-alpine
WORKDIR /app

RUN yarn global add serve

COPY --from=builder /app/build ./build

# Security: non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 3000
CMD ["serve", "-s", "build"]
