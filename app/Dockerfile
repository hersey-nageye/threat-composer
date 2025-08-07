# ---- Build Stage ----
FROM node:20-alpine AS builder
WORKDIR /app

COPY . .

RUN yarn install
RUN yarn build

# ---- Production Stage ----
FROM node:20-alpine
WORKDIR /app

COPY --from=builder /app/build ./build
RUN yarn global add serve

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 3000
CMD ["serve", "-s", "build"]
