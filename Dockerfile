# -------- Stage 1: Build Flutter Web --------
FROM cirrusci/flutter:stable-web as builder

# Set working directory
WORKDIR /app

# Only copy pubspec files first (improves caching)
COPY pubspec.yaml pubspec.lock ./

# Get dependencies
RUN flutter pub get

# Copy the rest of the project
COPY . .

# Build the web app in release mode
RUN flutter build web --release

# -------- Stage 2: Serve with NGINX --------
FROM nginx:alpine

# Remove default nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy built Flutter web app from builder
COPY --from=builder /app/build/web /usr/share/nginx/html

# Optional: copy a custom nginx.conf if you want to fine-tune caching, routes, etc.
# COPY nginx.conf /etc/nginx/nginx.conf



# Start nginx in foreground
CMD ["nginx", "-g", "daemon off;"]