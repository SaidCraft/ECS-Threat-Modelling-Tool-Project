# === Build Stage ===
FROM node:alpine3.21 AS build

WORKDIR /App

# Copy source files
COPY /app /App

# Install dependencies and build static files
RUN yarn install
RUN yarn build


# === Runtime Stage ===
FROM node:alpine3.21

WORKDIR /App

# Copy built static files only
COPY --from=build /App/build ./build

# Install serve CLI for static hosting
RUN yarn global add serve

EXPOSE 3000

# Run the static site
CMD ["serve", "-s", "build"]
