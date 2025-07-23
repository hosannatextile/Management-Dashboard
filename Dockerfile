# Use official Flutter image
FROM cirrusci/flutter:stable AS builder

WORKDIR /app

# Copy pubspec files and get dependencies
COPY pubspec.yaml ./
COPY pubspec.lock ./
RUN flutter pub get

# Copy the rest of the project
COPY . .

# Build for web
RUN flutter build web

# Final stage to serve with nginx
FROM nginx:alpine
COPY --from=builder /app/build/web /usr/share/nginx/html